<!DOCTYPE html>
<html lang="en"  class="bootstrap">
<head>
  <meta charset="utf-8" class="bootstrap">
  <title>Browse Files</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <!-- Le styles -->
  <link href="css/browser.css" rel="stylesheet">

  <!-- We need web context for requirejs and css -->
  <script type="text/javascript" src="webcontext.js?context=mantle&cssOnly=true"></script>

  <!-- Require File Browser -->
  <script type="text/javascript">
    function openRepositoryFile(path, mode) {
      if(!path) {
        return;
      }
      if(!mode) {
        mode = "edit";
      }

      // show the opened perspective
      parent.mantle_setPerspective('opened.perspective');
      window.parent.mantle_openRepositoryFile(path, mode);
    }

    var FileBrowser = null;
    pen.require(["js/browser"], function(pentahoFileBrowser) {
      FileBrowser = pentahoFileBrowser;

      FileBrowser.setOpenFileHandler(openRepositoryFile);
      FileBrowser.setContainer($("#fileBrowser"));
      FileBrowser.update();

      // refresh file list on successful delete
      window.top.mantle_addHandler("SolutionFileActionEvent", function(event){
        if(event.action == 'org.pentaho.mantle.client.commands.DeleteFileCommand'){
          if(event.message == 'Success'){
            FileBrowser.updateData();
          }
          else{
            window.top.mantle_showMessage('Error', event.message);
          }
        }
      });

      // refresh folder list on create new folder
      window.top.mantle_addHandler("SolutionFolderActionEvent", function(event){
        if(event.action == 'org.pentaho.mantle.client.commands.NewFolderCommand' ||
           event.action == 'org.pentaho.mantle.client.commands.PasteFilesCommand'){
          if(event.message == 'Success'){
            FileBrowser.update();
          }
          else{
            window.top.mantle_showMessage('Error', event.message);
          }
        }
      });
    });


  </script>

  <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
  <script src="bootstrap/js/html5shiv.js"></script>
  <![endif]-->

</head>

<body data-spy="scroll" data-target=".sidebar">


<div class="container-fluid main-container">
  <div id="fileBrowser" class="row-fluid" style="margin-bottom: 30px">
</div>


<!-- libs -->
<script type="text/javascript" src="lib/jquery/jquery-1.9.1.js"></script>
<script type="text/javascript" src="lib/underscore/underscore-min.js"></script>
<script type="text/javascript" src="lib/backbone/backbone.js"></script>

</body>
</html>

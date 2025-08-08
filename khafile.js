const project = new Project('Empty');

project.addAssets('Assets/*.png');
project.addShaders('Shaders/**');
project.addSources('Sources');

resolve(project);

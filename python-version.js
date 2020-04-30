const { exec } = require('child_process')
const python = process.env.PYTHON || 'python3'

const getPythonVersion = () => new Promise((resolve, reject) => {
  const command = `${python} -c "import sys;print('python'+str(sys.version_info[0])+'.'+str(sys.version_info[1]))"`
  exec(command, (error, stdout, stderr) => {
    if (error) {
      return reject(error)
    }

    console.log(`stdout: ${stdout}`)
    console.error(`stderr: ${stderr}`)

    resolve(stdout.replace(/\s+/g, ''))
  })
})

module.exports.python = async () => {
  const version = await getPythonVersion()

  return {
    version,
    prefix: version.replace('.', '')
  }
}

require File.expand_path('../../../spec_helper', __FILE__)

describe 'CPU probe' do
  before do
    @p = HostStats::Probes::Cpu.new
    sleep(0.1)
  end
  
  should 'return cpu cores count' do
    @p.list().should == %w(
        cpu.global
        cpu.0
        cpu.1
        cpu.2
        cpu.3
      )
  end
  
  should 'return global usage' do
    ret = @p.query('global')
    ret.class.should == Hash
    
    ret['user'].should.not == nil
    ret['sys'].should.not == nil
    ret['idle'].should.not == nil
    ret['combined'].should >= ret['user'] + ret['sys'] + ret['wait']
  end
  
  should 'return usage for one core' do
    ret = @p.query('cpu.1')
    ret.class.should == Hash
    
    ret['user'].should.not == nil
    ret['sys'].should.not == nil
    ret['idle'].should.not == nil
    ret['combined'].should >= ret['user'] + ret['sys'] + ret['wait']
  end

end
  

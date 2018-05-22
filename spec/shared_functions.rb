def fake_operatingsystem
  Facter.add(:operatingsystem) do
    setcode do
      'aristaeos'
    end
  end
end

Return-Path: <linux-efi+bounces-4274-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3F0AFFE56
	for <lists+linux-efi@lfdr.de>; Thu, 10 Jul 2025 11:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 199031C47EC5
	for <lists+linux-efi@lfdr.de>; Thu, 10 Jul 2025 09:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8880D2D3ED5;
	Thu, 10 Jul 2025 09:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4POTkIp"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0A728D82F;
	Thu, 10 Jul 2025 09:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752140410; cv=none; b=SQD8wPjdfCu6WMJW+4A7GTC+lLssu7GcQ0WIQEoA6qGaG1fGNoe/6vgvbXIIPRiWsiicEpkM2N/TeaV36jo8MnQmMqTnHGB7QawO7apUcDpsvBMjcC3ZlMtdfxDSl0KgPtiu1pCrdB7RKPcEb86GjDUThiGTHM3uihqRm4sPMV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752140410; c=relaxed/simple;
	bh=x+A+4ftMt9Yq8X3LVyeioVSBjpZxfMyX5lyRPLKUhi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AP5B924k8pVRAZPT1Sigv2VE1qfDhTw77c1OEGWVGmaW6je6NJQ5Gbgyp3O1r+rQ+3o5UHdiUcaxs/EkEuhl8zVmgn0eMoqQgg4HLQhYNlOP6p5eRdfHGvuN5Af+tb//BkBw0Vs09VCnCmYLhx4vZc+3Ufk8gEWxM1N5ESU7OyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4POTkIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D50C4CEE3;
	Thu, 10 Jul 2025 09:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752140410;
	bh=x+A+4ftMt9Yq8X3LVyeioVSBjpZxfMyX5lyRPLKUhi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L4POTkIpYO7M/uIVs2tfsDFKlBk6sV49cdEcWqTYA2YO5XVtTLLEMKbFqUWRJwOBm
	 Rn+GygnEloY8OsOuTn5T/RoB8FCvfiexHcHvjErCX4g1eRPKlgYybQyCj9BXlvjABl
	 IXs88RfBoD2e9sN3nJ+XUetLdfnI6nHf86zDcGYKWSLKSuKTstHCuAXjjD6SnH8O/E
	 ab1ld2U4/RlFvKtYkostKf9eluRdjbd4XVG3BVEtDW+hUyxMAyKNt7uaXfj9+dZwz6
	 SI6rg0mdeD0BeogTZqZ2H8nLAekV/NH/OBhTvtO6eHnmzdZgDviE1xRp/Rv6IJKCc5
	 ZEFzzXpewyXzA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uZnl3-000000007bx-0tkl;
	Thu, 10 Jul 2025 11:40:01 +0200
Date: Thu, 10 Jul 2025 11:40:01 +0200
From: Johan Hovold <johan@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Steev Klimaszewski <steev@kali.org>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-efi@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 6/8] firmware: qcom: scm: add modparam to control
 QSEECOM enablement
Message-ID: <aG-KcWsztfTUHE0Y@hovoldconsulting.com>
References: <20250625-more-qseecom-v4-0-aacca9306cee@oss.qualcomm.com>
 <20250625-more-qseecom-v4-6-aacca9306cee@oss.qualcomm.com>
 <aF0cyOpkjUI4R3bv@hovoldconsulting.com>
 <gqoba4uu62sh4qxapqkhlufxnliatevnsqcxvijvb74tposf2b@iyonh347aext>
 <aF1EDMsw1KQTlteX@hovoldconsulting.com>
 <cjinqyqn7qgvdoltoywxa2lq6bjyfrotmon3iv24tqt3bpdlpe@3xb2k42ffegj>
 <aF6Srse7BhDJkQiH@hovoldconsulting.com>
 <7jjxjkk6qwym2mt6xp7t2t4wckyrvwaj2ydubkimnx2oybitab@u4nhj5mib64l>
 <aGKGHvDzlKrBDrjN@hovoldconsulting.com>
 <af553qttxd6tqkypokqkgki3dceatsbqfw5botjrcesvg22nyr@zogoseo3j7hc>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af553qttxd6tqkypokqkgki3dceatsbqfw5botjrcesvg22nyr@zogoseo3j7hc>

On Tue, Jul 01, 2025 at 02:10:49PM +0300, Dmitry Baryshkov wrote:
> On Mon, Jun 30, 2025 at 02:42:06PM +0200, Johan Hovold wrote:

> > Here it's just Qualcomm doing something funny that affects their own
> > platforms. We should be able to figure this out without forcing users or
> > distros to pass command line parameters.
> 
> This is not intended for the normal working course, but for the initial
> bringup / nailing out issues after the bringup (e.g. after firmware
> upgrade).

And for that you do not need a module parameter either.

> > Do we know if there are any sc8280xp or x1e machines that boot off UFS?
> > 
> > If not (even with the exception of the CRDs) then it should be fine to
> > just whitelist the SoCs without any command line parameters.
> 
> I'm not aware of such platforms.

Then go for it.

> > Adding to a blacklist is bound to be overlooked, while adding to a
> > whitelist is not.
> 
> You can't overlook it since it is required as a part of almost any
> distro setup - point UEFI boot sequence to your new bootloader entry.

The distros don't do bring ups of these machines themselves.

> > I'd rather see you get to the bottom of the UFS boot issue and whether
> > there is some way to determine this programmatically.
> 
> I don't see a good way to do that - UFS might be probed very late, it
> might be unused for the boot at all, etc.

How about asking the Qualcomm firmware team?

Again, there's no rush here. Whitelisting is perfectly fine until then.

> > If everything that's currently upstream boots from NVMe that may not
> > necessarily mean it works for devices using UFS.
> 
> And? I don't care that much about theoretical devices here.

It's not theoretical. We know that the UEFI vars on the CRDs are not
persistent when booting off UFS. Not to mention your Yoga.

> > > > But if this series now enables broken EFI variable support on every
> > > > other device then I don't think that's ok (even if you provide a command
> > > > line parameter that each user now have to pass).
> > > > 
> > > > Then I'd rather see a proposal for how to determine which machines
> > > > support this or not, information which was not available when this
> > > > interface was reverse engineered and where a conservative whitelist
> > > > approach made perfect sense.
> > > 
> > > WIP
> > 
> > Good. We can manage with adding new entries for a while still while you
> > guys at Qualcomm work this out.
> 
> You (we) guys at Linaro could have figured that out too ;-)

Linaro relies on Qualcomm to provide details on things like this. As you
know.

Johan


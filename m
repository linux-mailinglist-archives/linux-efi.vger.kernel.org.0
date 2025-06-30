Return-Path: <linux-efi+bounces-4051-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A29AEDD4D
	for <lists+linux-efi@lfdr.de>; Mon, 30 Jun 2025 14:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9470F3AFDFC
	for <lists+linux-efi@lfdr.de>; Mon, 30 Jun 2025 12:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E91926CE3B;
	Mon, 30 Jun 2025 12:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7hKBkTX"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC4F28C2A2;
	Mon, 30 Jun 2025 12:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751287328; cv=none; b=R/Zx+//TTsApFauZ2Nwj0wYRC6WWl+RDsW5OUcMxRa1ZUAbrudQ2Aiw1QvhIlrzxJ4LHLPohr1A/gzPBTsuxngyF7tFWV3xes9AxOECY0/ndSoSH0ZvbKBbYPy3KL4Rqudx3kuKXvoE8QwU0SFmhsigA1zHlCq2zLiLSM38d7mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751287328; c=relaxed/simple;
	bh=AVr3XLar8F52KSwgOTwNXqs04b5Zwkq/z4TGy8s0YDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9ahL9342loq2apTEuna81MOBppoQLHFwupgW+erFPJpHpl1JP96bWbECXcIUjh4HcKcQyqhLoOgHudKNBQoOEHKamMwEVryhK3byqr/1ywO8HEy+/43CkXx/5NZe5Q9uHkdUuby36N3iZjWN/U6bCLdkP5dnVZwZbKyJzdx3jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7hKBkTX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF8AC4CEE3;
	Mon, 30 Jun 2025 12:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751287327;
	bh=AVr3XLar8F52KSwgOTwNXqs04b5Zwkq/z4TGy8s0YDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o7hKBkTXtFfPgRJYk9wUOcBy49ZyGrV4M1bp51DiE4ie4UQw/DEEVdCQgxkOQOLfG
	 mpAmBkNJY39Yve0AuAPvUoJmPFIJtMWCwwxB81KgIEfjuIeuKfZjchNKGxiQ9sDVu6
	 Rsre+FhbyJcMYEskYqmG/DBkxoYLh8SHRfD3o26lgrd2t4i7VjigIyasZ0RI9uY35G
	 /pAtWtKrH8qnMPYZ0i8/H9kl6aInR1cFU9Gb4O/WfIZMx83WM0P6dw5hoPSag5YUNE
	 zB6m7Sw4UtAZOaCiV/XY41uJ7LMPqegyTLglCHIUBmTSxrjyKvkipknsKluwx4zM2k
	 pE4ym3MNDH+rQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uWDpm-000000008CN-258N;
	Mon, 30 Jun 2025 14:42:06 +0200
Date: Mon, 30 Jun 2025 14:42:06 +0200
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
Message-ID: <aGKGHvDzlKrBDrjN@hovoldconsulting.com>
References: <20250625-more-qseecom-v4-0-aacca9306cee@oss.qualcomm.com>
 <20250625-more-qseecom-v4-6-aacca9306cee@oss.qualcomm.com>
 <aF0cyOpkjUI4R3bv@hovoldconsulting.com>
 <gqoba4uu62sh4qxapqkhlufxnliatevnsqcxvijvb74tposf2b@iyonh347aext>
 <aF1EDMsw1KQTlteX@hovoldconsulting.com>
 <cjinqyqn7qgvdoltoywxa2lq6bjyfrotmon3iv24tqt3bpdlpe@3xb2k42ffegj>
 <aF6Srse7BhDJkQiH@hovoldconsulting.com>
 <7jjxjkk6qwym2mt6xp7t2t4wckyrvwaj2ydubkimnx2oybitab@u4nhj5mib64l>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7jjxjkk6qwym2mt6xp7t2t4wckyrvwaj2ydubkimnx2oybitab@u4nhj5mib64l>

On Sat, Jun 28, 2025 at 06:03:40PM +0300, Dmitry Baryshkov wrote:
> On Fri, Jun 27, 2025 at 02:46:38PM +0200, Johan Hovold wrote:
> > On Fri, Jun 27, 2025 at 02:33:27AM +0300, Dmitry Baryshkov wrote:
> > > On Thu, Jun 26, 2025 at 02:58:52PM +0200, Johan Hovold wrote:
> > > > On Thu, Jun 26, 2025 at 02:08:23PM +0300, Dmitry Baryshkov wrote:
> > > > > On Thu, Jun 26, 2025 at 12:11:20PM +0200, Johan Hovold wrote:

> > > > You basically know by now which machines supports qseecom and which do
> > > > not, right (e.g. UFS storage means non-persistent EFI vars)?
> > 
> > Do you have a theory about why on some platforms, like the one you're
> > currently adding support for, writing UEFI variables does not work?
> > 
> > Can you please include that information in the series so we can consider
> > alternate routes for replacing the current whitelist with this black and
> > white thing you're going for.
> > 
> > Is it related to UFS at all, for example?
> 
> Strictly speaking I have no confirmation (yet), but there are two
> theories:
> 
> - UFS vs SPI-NOR

Someone with time and the sc8280xp and x1e CRDs should be able to set
them up for booting from either UFS or SPI-NOR and see if that makes a
difference to confirm this.

So far my sc8280xp CRD with UFS fails, while Konrad's work with SPI-NOR
(NVMe).

My x1e CRD works but also boots from SPI-NOR (NVMe).

The Yoga C630 booting from UFS is also known to fail.

> - a edk2 PCD which controls whether SetVariable commits immediately or
>   whether it just buffers data until EBS (or other call).
> 
> > 
> > > > And it's a pretty bad user experience to have people trying to write
> > > > efivariables when setting up a machine and then spend hours trying to
> > > > debug why they don't persist after a reboot.
> > > > 
> > > > I don't think that's fair to users.
> > > 
> > > So, is it a user or a developer, trying to port Linux to a new hardware?
> > > Also, R/O implementation makes it obvious, that the variables do not
> > > persist.
> > 
> > A developer enabling support for a new platform can patch the driver and
> > does not need a command line option.
> 
> Yes. But it's easier to debug things this way. Consider all ACPI-related
> or UEFI-related kernel options that we have.

That's because there is a common kernel implementation used across a
host of fw implementations.

Here it's just Qualcomm doing something funny that affects their own
platforms. We should be able to figure this out without forcing users or
distros to pass command line parameters.

> > If you enable it by default, suddenly a bunch of end-users are going to
> > have to debug why storing efi variables silently fails. That would not
> > be fair to them.
> 
> I'm enabling this only for platforms where all existing devices are
> listed in the current whitelist.

Do we know if there are any sc8280xp or x1e machines that boot off UFS?

If not (even with the exception of the CRDs) then it should be fine to
just whitelist the SoCs without any command line parameters.

> > > > Let whoever brings up a new machine figure this out. It's just one
> > > > entry, no scaling issues, and we get accurate information (unless
> > > > Qualcomm, who sits on the documentation, is willing to provide it
> > > > upfront).
> > > 
> > > And that's not really scallable. All other parts of a particular device
> > > are described by the DT only (that's especially true on the PMIC GLINK
> > > machines). If we are to support new laptop in e.g. distro kernel, we
> > > need to provide a DT... and a patch for qcom-scm driver. I'd very much
> > > prefer to do it other way around: provide a DT and patch qcom-scm if the
> > > laptop is any way different from other laptops. E.g. we know that all
> > > X1Elite laptops support R/W EFI variables.
> > 
> > But this is just kicking the can and putting the burden on someone else.
> > Now a user or distro would need to pass command line parameters after
> > spending time debugging why efi variable updates do not persist after a
> > reboot.
> 
> The original developer for new DTS will have to do that anyway, if
> something fails. And once it is done, we can add a quirk for that pure
> platform. However the majority of the case can go without extra quirks.

Adding to a blacklist is bound to be overlooked, while adding to a
whitelist is not.

> As you can see, all X-Elite / X-Plus and majority of SC8280XP platforms
> already are in the whitelist. Once we sort out SC8280XP-CRD issue, all
> SC8280XP platforms supported upstream will have an entry in the
> allowlist, which means we can convert them to the wildcard + quirks.

I'd rather see you get to the bottom of the UFS boot issue and whether
there is some way to determine this programmatically.

> > If we know with reasonable certainty that all, say X1E, devices works,
> > then that that's one thing.
> 
> Yes, we do. You can hand-compare the lists too (I did).

If everything that's currently upstream boots from NVMe that may not
necessarily mean it works for devices using UFS.

> > But if this series now enables broken EFI variable support on every
> > other device then I don't think that's ok (even if you provide a command
> > line parameter that each user now have to pass).
> > 
> > Then I'd rather see a proposal for how to determine which machines
> > support this or not, information which was not available when this
> > interface was reverse engineered and where a conservative whitelist
> > approach made perfect sense.
> 
> WIP

Good. We can manage with adding new entries for a while still while you
guys at Qualcomm work this out.

Johan


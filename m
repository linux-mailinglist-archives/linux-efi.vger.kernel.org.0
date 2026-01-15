Return-Path: <linux-efi+bounces-5996-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFF0D25374
	for <lists+linux-efi@lfdr.de>; Thu, 15 Jan 2026 16:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3CC6D3019C59
	for <lists+linux-efi@lfdr.de>; Thu, 15 Jan 2026 15:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10A53AE6F3;
	Thu, 15 Jan 2026 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="csR2i0zH"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6243ACF14;
	Thu, 15 Jan 2026 15:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768489858; cv=none; b=ieuBRWJ3o/JPqazi/DJKDDNFDMeyJekHwxF11RiKhcenqX+vxVevOAIpAJEKD66IUJJIVBMLcGMgQOhO2axfOszXtFvOjHf/rbx3otq6kwve7DmtU6eXSrALxaqqwV1qkOro45tBTc8G+Ml+b8XEMaaOhQlC9Scs+NyS+RECFUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768489858; c=relaxed/simple;
	bh=zJtKOUTDeVup7QvvLjg/CY50ojhXg1JVcSwyHLTVV5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qc+QMuMgXmSJdek7U4pq/Gx9V/uhH6JVBj4vrB2punBOymxmin0LgzMbiVYNahSrERF5liekgtGUN+wObx9UqfqUIK+NO4und0BJDNCm/Y1CJDGgYcX9XSi32CfozfmSpY6gXKJkLAXjIskGfFvy0lDyooWXCprSh1MXi5EaEWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=csR2i0zH; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768489844; x=1800025844;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zJtKOUTDeVup7QvvLjg/CY50ojhXg1JVcSwyHLTVV5U=;
  b=csR2i0zHpPfqwMAa08vdttQyI14WuYGUm2hC7qcPKPWKV/A8Y60C1eTS
   HrjTwslgskiP7jJGQw1hj2CGBi+eWVzgRAyNVYFqy2GUaVfvPTnPRx7wN
   VEK5dzuKwD/AFQXqC8D+TKjwVtk+ExTCXzyDru0+hRQ+9ptT9sOZLjp9B
   OEJjZH44e5kAK46AWBEJuzdQ555/ISMywx/sX0Q6OuJlejS0ZaalmxtBl
   k7aMiz924ANLoeqNu1KVW2BOAPkTzZ+sjamT0F2RDxa4sOYrlUvh5XFNJ
   j43hztcW5bkJjrEgsmm8uFu9Rk5zx4E/YyzsRIviZVSbNERhYORV5vBFS
   w==;
X-CSE-ConnectionGUID: m0jbVvRtQxGWhtkXWPPWiw==
X-CSE-MsgGUID: V0OwP6l1QZe0NjUjsUO15w==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="80439993"
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="80439993"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 07:10:40 -0800
X-CSE-ConnectionGUID: QlyxHSHiTzCEbE1DbfKHgA==
X-CSE-MsgGUID: Hevrt8lZSOytYcWKGKE26Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="205005261"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.53])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 07:10:28 -0800
Date: Thu, 15 Jan 2026 17:10:24 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Zack Rusin <zack.rusin@broadcom.com>,
	dri-devel@lists.freedesktop.org,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org, Ard Biesheuvel <ardb@kernel.org>,
	Ce Sun <cesun102@amd.com>, Chia-I Wu <olvaffe@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Dave Airlie <airlied@redhat.com>,
	Deepak Rawat <drawat.floss@gmail.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Hans de Goede <hansg@kernel.org>,
	Hawking Zhang <Hawking.Zhang@amd.com>, Helge Deller <deller@gmx.de>,
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Lijo Lazar <lijo.lazar@amd.com>, linux-efi@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Lyude Paul <lyude@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Maxime Ripard <mripard@kernel.org>, nouveau@lists.freedesktop.org,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>, spice-devel@lists.freedesktop.org,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	virtualization@lists.linux.dev,
	Vitaly Prosyak <vitaly.prosyak@amd.com>
Subject: Re: [PATCH 00/12] Recover sysfb after DRM probe failure
Message-ID: <aWkDYO1o9T1BhvXj@intel.com>
References: <20251229215906.3688205-1-zack.rusin@broadcom.com>
 <c816f7ed-66e0-4773-b3d1-4769234bd30b@suse.de>
 <CABQX2QNQU4XZ1rJFqnJeMkz8WP=t9atj0BqXHbDQab7ZnAyJxg@mail.gmail.com>
 <97993761-5884-4ada-b345-9fb64819e02a@suse.de>
 <9058636d-cc18-4c8f-92cf-782fd8f771af@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9058636d-cc18-4c8f-92cf-782fd8f771af@amd.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland

On Thu, Jan 15, 2026 at 03:39:00PM +0100, Christian König wrote:
> Sorry to being late, but I only now realized what you are doing here.
> 
> On 1/15/26 12:02, Thomas Zimmermann wrote:
> > Hi,
> > 
> > apologies for the delay. I wanted to reply and then forgot about it.
> > 
> > Am 10.01.26 um 05:52 schrieb Zack Rusin:
> >> On Fri, Jan 9, 2026 at 5:34 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >>> Hi
> >>>
> >>> Am 29.12.25 um 22:58 schrieb Zack Rusin:
> >>>> Almost a rite of passage for every DRM developer and most Linux users
> >>>> is upgrading your DRM driver/updating boot flags/changing some config
> >>>> and having DRM driver fail at probe resulting in a blank screen.
> >>>>
> >>>> Currently there's no way to recover from DRM driver probe failure. PCI
> >>>> DRM driver explicitly throw out the existing sysfb to get exclusive
> >>>> access to PCI resources so if the probe fails the system is left without
> >>>> a functioning display driver.
> >>>>
> >>>> Add code to sysfb to recever system framebuffer when DRM driver's probe
> >>>> fails. This means that a DRM driver that fails to load reloads the system
> >>>> framebuffer driver.
> >>>>
> >>>> This works best with simpledrm. Without it Xorg won't recover because
> >>>> it still tries to load the vendor specific driver which ends up usually
> >>>> not working at all. With simpledrm the system recovers really nicely
> >>>> ending up with a working console and not a blank screen.
> >>>>
> >>>> There's a caveat in that some hardware might require some special magic
> >>>> register write to recover EFI display. I'd appreciate it a lot if
> >>>> maintainers could introduce a temporary failure in their drivers
> >>>> probe to validate that the sysfb recovers and they get a working console.
> >>>> The easiest way to double check it is by adding:
> >>>>    /* XXX: Temporary failure to test sysfb restore - REMOVE BEFORE COMMIT */
> >>>>    dev_info(&pdev->dev, "Testing sysfb restore: forcing probe failure\n");
> >>>>    ret = -EINVAL;
> >>>>    goto out_error;
> >>>> or such right after the devm_aperture_remove_conflicting_pci_devices .
> >>> Recovering the display like that is guess work and will at best work
> >>> with simple discrete devices where the framebuffer is always located in
> >>> a confined graphics aperture.
> >>>
> >>> But the problem you're trying to solve is a real one.
> >>>
> >>> What we'd want to do instead is to take the initial hardware state into
> >>> account when we do the initial mode-setting operation.
> >>>
> >>> The first step is to move each driver's remove_conflicting_devices call
> >>> to the latest possible location in the probe function. We usually do it
> >>> first, because that's easy. But on most hardware, it could happen much
> >>> later.
> >> Well, some drivers (vbox, vmwgfx, bochs and currus-qemu) do it because
> >> they request pci regions which is going to fail otherwise. Because
> >> grabbining the pci resources is in general the very first thing that
> >> those drivers need to do to setup anything, we
> >> remove_conflicting_devices first or at least very early.
> > 
> > To my knowledge, requesting resources is more about correctness than a hard requirement to use an I/O or memory range. Has this changed?
> 
> Nope that is not correct.
> 
> At least for AMD GPUs remove_conflicting_devices() really early is necessary because otherwise some operations just result in a spontaneous system reboot.	
> 
> For example resizing the PCIe BAR giving access to VRAM or disabling VGA emulation (which AFAIK is used for EFI as well) is only possible when the VGA or EFI framebuffer driver is kicked out first.
> 
> And disabling VGA emulation is among the absolutely first steps you do to take over the scanout config.

It's similar for Intel. For us VGA emulation won't be used for
EFI boot, but we still can't have the previous driver poking
around in memory while the real driver is initializing. The
entire memory layout may get completely shuffled so there's
no telling where such memory accesses would land.

And I suppose reBAR is a concern for us as well.

-- 
Ville Syrjälä
Intel


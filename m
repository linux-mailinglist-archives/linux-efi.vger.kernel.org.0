Return-Path: <linux-efi+bounces-5709-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C263C8CA6A
	for <lists+linux-efi@lfdr.de>; Thu, 27 Nov 2025 03:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 165FD4E0373
	for <lists+linux-efi@lfdr.de>; Thu, 27 Nov 2025 02:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90442258EE9;
	Thu, 27 Nov 2025 02:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DqVsP5/1"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F18242D6B
	for <linux-efi@vger.kernel.org>; Thu, 27 Nov 2025 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764210034; cv=none; b=IbQPoByicovgKM0VeICWHxxyOVW/g6UB1k3YXE3rLC5WQhUg32p7ML7Iz0tgAMzbzL53tCYmGjWuFHlE6WDR1yd3PeIpOZEPbRfTU2kdd5h7XVusRZKfz3/U7UJCevr4K1N8qlh+P6koTkCuUQfNtz0OJbei1dtKddCdhIBGtCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764210034; c=relaxed/simple;
	bh=O5+FwqoY/zKpG5o8W+7yvGXAPlP0E+ecret6xMCqLzA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQsQHd0KQp7hbc4JxYV8ytC+SrlmnDVZxMGfThzMyEozrHpIKrVxZFjuryWg8ARnqNYlkAcDvXvtMPYhqS9pDSM1GIpzbdtQnsvvP3N3nmhogAwc/FCCY3tqozjL9kMFy72qIs4QRTBuwEZEsfjq+bNrLlPGJdMmHhX5wEN4Fk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DqVsP5/1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso1090545e9.2
        for <linux-efi@vger.kernel.org>; Wed, 26 Nov 2025 18:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764210029; x=1764814829; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4URCfDbXaJDpqc3Jy/ygM5tnfYeP0a6DjdNrUnYNok=;
        b=DqVsP5/1cU0UgBXytfZJCMR7JVyL6LKJEnUvhD5SsNp78Oj2kUl775cO9xn5nblNLm
         SqcnG4a7aPCruqgOMMR1kGd4uvip517CNPJpMmV0C/ogJVwSITCjTWqIwV7SsO7me10o
         8gfMhs7WXxJ8fk+CQ663gB3yXHp4qlcyAmAqiflp4DUOmyeO907avn7fzdrxi7CqezAE
         dHOv9/pajYIu1BkXXpGVScKwDNyIaJ46vloWBW/hNdER6fcoTg5pCiZ2SWnINzRkFD4f
         lSvjKknDVOuAcxiNbBS3OpDqO233o16SvPAPf0Sm7cPju4YlLPrjzqZPXF4zIsDs4fVA
         gnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764210029; x=1764814829;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K4URCfDbXaJDpqc3Jy/ygM5tnfYeP0a6DjdNrUnYNok=;
        b=C1l9WKnF0bvkobn0m23XG1rJUmrgl4fXx0E3ge7hq8qgjt6SgzEb/OBrzGsXaIKAuz
         4g38j9Fwr4wQ180Nub9qw3pVJ4zBPk0sTu9+w92yVTB89cLyL5Sco9Ewyh4KsRt8SGiQ
         bY8HoM8bWh+iaIxN73vrhI5rhEOXGeNmJxSv8EYXC5fFephdI4t9F91tzkCoP4I1+cTu
         wQddTyiQgXXqeUFhux/wY5pxaU0Nh45D5x6MXgH/tVU4eOcL0DwMBjjPsOSFoGbaDesq
         mwN4BgRFX584+fQi54uLruF4njUSec6zhe/fQ8vIiKrzlGcGadYsG0APsOUCtqZxl7WT
         nxkg==
X-Forwarded-Encrypted: i=1; AJvYcCVrYBJ5aMq/idGxHrjtBIHU4c57wsOVU+1+mis1zkgfS5cwGRZWu0r+FcYrrWzKYwPCi+pbkifNCqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo3zbuIfkdkcCwN8hEEnmRz87uPgPPZOjHnfycw2MRLYclSPlv
	nEy3UCJU9+iJF/nY3AiSFvJsMWnOP676a+az5THcb6j63hyrS31qrIu4ZQqfLAuaCe4=
X-Gm-Gg: ASbGncvhmpbY1II0CDkvq1E00Kv8ehhZ7m4MwkVfvV0mv+9Nd/VGd/rC9d5gn44irv4
	dJh0RM9Edk2bKLMutkCxQDzdPCtOGjhlEt0kMoND4oPlcAXxerj5X8CsmC5AOCvzpc0RAV52Tgb
	5xHNPjhn7rSS2dQUajy+89JrJHhP5Ugmw2T50BAbzw8HGNltz3HJKwsJmfMAgF47HYTj/b0rrg5
	hKOwGn6X0zbUmWT1UAc5s0XugJCZvo41U7spkBedX1EkeZVqA5c2uok1Rs3NO5WqUBS3EmwX8yK
	8Sq7fWOjIKQt5xXrF+2oQWmDk3ji+qDNezwGnDpcyG8sHIumjYByqjFkyBw37LNww5yXNru9TeE
	uiy1Rumsjwfsphh3CVNfhtxt4oCVFBAiBEtgCh4mutB6F/TXtlHHKOXDfPsGJVNaOW7rJCkMKRN
	b6Z/BOJBEWVXQQuCxSPYq+nI5mjVbwzRfH
X-Google-Smtp-Source: AGHT+IGspC1YV2yyiMXXnAe8/Td7EsFQhaqJU5qYzu5f0NQl+Us+ioM0vDMgGxEbw6PNx9+MNqPMRQ==
X-Received: by 2002:a05:600c:474b:b0:477:9dc1:b706 with SMTP id 5b1f17b1804b1-477c01b494fmr204934695e9.19.1764210029052;
        Wed, 26 Nov 2025 18:20:29 -0800 (PST)
Received: from r1chard (1-169-246-18.dynamic-ip.hinet.net. [1.169.246.18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3477b20b5d6sm67743a91.6.2025.11.26.18.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 18:20:28 -0800 (PST)
From: Richard Lyu <richard.lyu@suse.com>
X-Google-Original-From: Richard Lyu <r1chard@r1chard>
Date: Thu, 27 Nov 2025 10:20:20 +0800
To: Thomas Zimmermann <tzimmermann@suse.de>, ardb@kernel.org,
	javierm@redhat.com, arnd@arndb.de, helgaas@kernel.org
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 0/9] arch,sysfb,efi: Support EDID on non-x86 EFI
 systems
Message-ID: <aSe1ZBXa3JBidhem@r1chard>
References: <20251126160854.553077-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126160854.553077-1-tzimmermann@suse.de>
User-Agent: Mutt/2.2.13 (2024-03-09)

Hi Thomas,

I am attempting to test this patch series but encountered merge conflicts when applying it to various trees.
Could you please clarify the specific base commit (or branch/tag) this series was generated against?

When testing on the next branch on commits 7a2ff00 and e41ef37, I hit a conflict on PATCH v3 4/9:
patching file drivers/pci/vgaarb.c
Hunk #2 FAILED at 557.
1 out of 2 hunks FAILED -- rejects in file drivers/pci/vgaarb.c

When testing against 3a86608 (Linux 6.18-rc1), the following conflicts occurred:
patching file drivers/gpu/drm/sysfb/efidrm.c
Hunk #1 FAILED at 24.
1 out of 2 hunks FAILED -- rejects in file drivers/gpu/drm/sysfb/efidrm.c
patching file drivers/gpu/drm/sysfb/vesadrm.c
Hunk #1 FAILED at 25.
1 out of 2 hunks FAILED -- rejects in file drivers/gpu/drm/sysfb/vesadrm.c

Please let me know the correct base, and I will retest.

Thanks,
Richard Lyu

On 2025/11/26 17:03, Thomas Zimmermann wrote:
> Replace screen_info and edid_info with sysfb_primary_device of type
> struct sysfb_display_info. Update all users. Then implement EDID support
> in the kernel EFI code.
> 
> Sysfb DRM drivers currently fetch the global edid_info directly, when
> they should get that information together with the screen_info from their
> device. Wrapping screen_info and edid_info in sysfb_primary_display and
> passing this to drivers enables this.
> 
> Replacing both with sysfb_primary_display has been motivate by the EFI
> stub. EFI wants to transfer EDID via config table in a single entry.
> Using struct sysfb_display_info this will become easily possible. Hence
> accept some churn in architecture code for the long-term improvements.
> 
> Patches 1 and 2 reduce the exposure of screen_info in EFI-related code.
> 
> Patch 3 adds struct sysfb_display_info.
> 
> Patch 4 replaces scren_info with sysfb_primary_display. This results in
> several changes throught the kernel, but is really just a refactoring.
> 
> Patch 5 updates sysfb to transfer sysfb_primary_display to the related
> drivers.
> 
> Patch 6 moves edid_info into sysfb_primary_display. This resolves some
> drivers' reference to the global edid_info, but also makes the EDID data
> available on non-x86 architectures.
> 
> Patches 7 and 8 add support for EDID transfers on non-x86 EFI systems.
> 
> Patch 9 cleans up the config-table allocation to be easier to understand.
> 
> v3:
> - replace SCREEN_INFO table entry (Ard)
> - merge libstub patch into kernel patch
> v2:
> - combine v1 of the series at [1] plus changes from [2] and [3].
> 
> [1] https://lore.kernel.org/dri-devel/20251121135624.494768-1-tzimmermann@suse.de/
> [2] https://lore.kernel.org/dri-devel/20251015160816.525825-1-tzimmermann@suse.de/
> [3] https://lore.kernel.org/linux-efi/20251119123011.1187249-5-ardb+git@google.com/
> 
> Thomas Zimmermann (9):
>   efi: earlycon: Reduce number of references to global screen_info
>   efi: sysfb_efi: Reduce number of references to global screen_info
>   sysfb: Add struct sysfb_display_info
>   sysfb: Replace screen_info with sysfb_primary_display
>   sysfb: Pass sysfb_primary_display to devices
>   sysfb: Move edid_info into sysfb_primary_display
>   efi: Refactor init_primary_display() helpers
>   efi: Support EDID information
>   efi: libstub: Simplify interfaces for primary_display
> 
>  arch/arm64/kernel/image-vars.h                |  2 +-
>  arch/loongarch/kernel/efi.c                   | 38 ++++-----
>  arch/loongarch/kernel/image-vars.h            |  2 +-
>  arch/riscv/kernel/image-vars.h                |  2 +-
>  arch/x86/kernel/kexec-bzimage64.c             |  4 +-
>  arch/x86/kernel/setup.c                       | 16 ++--
>  arch/x86/video/video-common.c                 |  4 +-
>  drivers/firmware/efi/earlycon.c               | 42 +++++-----
>  drivers/firmware/efi/efi-init.c               | 46 ++++++-----
>  drivers/firmware/efi/efi.c                    |  4 +-
>  drivers/firmware/efi/libstub/Makefile         |  2 +-
>  drivers/firmware/efi/libstub/efi-stub-entry.c | 36 +++++++--
>  drivers/firmware/efi/libstub/efi-stub.c       | 49 +++++++----
>  drivers/firmware/efi/libstub/efistub.h        |  7 +-
>  .../firmware/efi/libstub/primary_display.c    | 41 ++++++++++
>  drivers/firmware/efi/libstub/screen_info.c    | 53 ------------
>  drivers/firmware/efi/libstub/zboot.c          |  6 +-
>  drivers/firmware/efi/sysfb_efi.c              | 81 ++++++++++---------
>  drivers/firmware/sysfb.c                      | 13 +--
>  drivers/firmware/sysfb_simplefb.c             |  2 +-
>  drivers/gpu/drm/sysfb/efidrm.c                | 14 ++--
>  drivers/gpu/drm/sysfb/vesadrm.c               | 14 ++--
>  drivers/hv/vmbus_drv.c                        |  6 +-
>  drivers/pci/vgaarb.c                          |  4 +-
>  drivers/video/Kconfig                         |  8 +-
>  drivers/video/fbdev/core/fbmon.c              |  8 +-
>  drivers/video/fbdev/efifb.c                   | 10 ++-
>  drivers/video/fbdev/vesafb.c                  | 10 ++-
>  drivers/video/fbdev/vga16fb.c                 |  8 +-
>  drivers/video/screen_info_pci.c               |  5 +-
>  include/linux/efi.h                           |  9 ++-
>  include/linux/screen_info.h                   |  2 -
>  include/linux/sysfb.h                         | 23 ++++--
>  include/video/edid.h                          |  4 -
>  34 files changed, 321 insertions(+), 254 deletions(-)
>  create mode 100644 drivers/firmware/efi/libstub/primary_display.c
>  delete mode 100644 drivers/firmware/efi/libstub/screen_info.c
> 
> 
> base-commit: d724c6f85e80a23ed46b7ebc6e38b527c09d64f5
> -- 
> 2.51.1
> 


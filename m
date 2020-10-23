Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1EA9296FB6
	for <lists+linux-efi@lfdr.de>; Fri, 23 Oct 2020 14:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464088AbgJWMu7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 23 Oct 2020 08:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S464037AbgJWMu6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 23 Oct 2020 08:50:58 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E3CC0613CE
        for <linux-efi@vger.kernel.org>; Fri, 23 Oct 2020 05:50:58 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w23so240999wmi.4
        for <linux-efi@vger.kernel.org>; Fri, 23 Oct 2020 05:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vbqBP2ZY0xMRiExVfDd/v/5KCD0Phk5xDcE5NH6SedY=;
        b=iT6ZcR4xHwI0htv/Hr6Bn3r2nZJnsuNmX3/jLRMt1NHDvU8EsWs7TXggWyBG8sWOlO
         JooF5vC5QVMQnwC6pKrL268GFHgHbcMxct2Nibeu8VrtSI1cqZZbC1Pr6ujQKQheuvpk
         l0ycHHvRcyLhJBSnj8yYskwb6AGPj6DmC3Z0I+T8+Gogc4bmXXfmayJpSutPWGRrFvsu
         Hc91bIP4sT9NZHsDLquJymTTQ88BgpFr5cGuc5jKk50JvsXMExliLq7lBiF1NxU5ZV4V
         rMF5xJVcFVSCrEX1yNukj0T3zdxDGDp8gCD0f7vcCMwBQZ2Vit7EiMSGvZLICbxFjINK
         Uo3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vbqBP2ZY0xMRiExVfDd/v/5KCD0Phk5xDcE5NH6SedY=;
        b=ZrzZZODPvo1N4zMLJegKbRFUbqD39j/crCGkNupU/8fIMRRavIpIuPeQRFAhUk2gEr
         n8V2taDrzramw3b3OvXc+bZIccEt3bo5kTnZE1MXllT+32yHrbAl18rUNJdScsWHYLy3
         UiFIfVqPR9NhJ1E5dC9mWLo+1msxXKDtJd4kGUDR+kfDMYHKzjwLLFMvd7GV0SCWW2ov
         uVKXXEbOwrb4t2Kdx5RU0Pnhm4ELUbfyffbFpW1TPs8D7FZ0mEVk4CDbIhwRCrNlRkvb
         ZgHivmCBT0mhvEOt3igBctXPwdy01jaoB7o7JiJ+csRwQqGjN8A/mOrnQDZsz/z1efVP
         48bA==
X-Gm-Message-State: AOAM530EaZMeI4yLTsqr2fV/asPi9Rj9VdH8VC2jKbbHbhAdIdjHRvDl
        MCksJKsUNpQRupUDStuJNdfnFA==
X-Google-Smtp-Source: ABdhPJy3I8Yv9/uoYEbyTIU4d3WSSDnYgVeU2dOwWCl6BKvsgNZKhk6uptko2VkEIR7O+hG8X7UhUA==
X-Received: by 2002:a1c:2283:: with SMTP id i125mr2090245wmi.41.1603457457273;
        Fri, 23 Oct 2020 05:50:57 -0700 (PDT)
Received: from vanye (cpc92880-cmbg19-2-0-cust79.5-4.cable.virginm.net. [82.27.104.80])
        by smtp.gmail.com with ESMTPSA id z191sm3275978wme.30.2020.10.23.05.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 05:50:56 -0700 (PDT)
Date:   Fri, 23 Oct 2020 13:50:55 +0100
From:   Leif Lindholm <leif@nuviainc.com>
To:     Ard Biesheuvel <ard.biesheuvel@arm.com>
Cc:     linux-efi@vger.kernel.org, grub-devel@gnu.org,
        daniel.kiper@oracle.com
Subject: Re: [PATCH 0/4] linux: implement LoadFile2 initrd loading
Message-ID: <20201023125055.GE1664@vanye>
References: <20201023120825.30466-1-ard.biesheuvel@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023120825.30466-1-ard.biesheuvel@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Oct 23, 2020 at 14:08:21 +0200, Ard Biesheuvel wrote:
> This implements the LoadFile2 initrd loading protocol, which is
> essentially a callback face into the bootloader to load the initrd
> data into a caller provided buffer. This means the bootloader no
> longer has to contain any policy regarding where to load the initrd
> (which differs between architectures and kernel versions) and no
> longer has to manipulate arch specific data structures such as DT
> or struct bootparams to inform the OS where the initrd resides in
> memory.
> 
> Sample output from booting a recent Linux/arm64 kernel:
> 
>   grub> insmod part_msdos
>   grub> linux (hd0,msdos1)/Image
>   grub> initrd (hd0,msdos1)/initrd.img
>   grub> boot
>   EFI stub: Booting Linux Kernel...
>   EFI stub: EFI_RNG_PROTOCOL unavailable, KASLR will be disabled
>   EFI stub: Generating empty DTB
>   EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path
>   EFI stub: Exiting boot services and installing virtual address map...
>   [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x411fd070]

I don't review enough grub code to be certain I've caught all aspects
of style adherence, so with that in mind, for 1-2/4:
Reviewed-by: Leif Lindholm <leif@nuviainc.com>

For 3-4/4, I did have some minor comments, but this is a really great
feature and I would like to see it merged.

/
    Leif

> Cc: grub-devel@gnu.org
> Cc: daniel.kiper@oracle.com
> Cc: leif@nuviainc.com
> 
> Ard Biesheuvel (4):
>   loader/linux: permit NULL argument for argv[] in grub_initrd_load()
>   efi: add definition of LoadFile2 protocol
>   efi: implemented LoadFile2 initr loading protocol for Linux
>   linux: ignore FDT unless we need to modify it
> 
>  grub-core/commands/efi/lsefi.c |   1 +
>  grub-core/loader/arm64/linux.c | 139 ++++++++++++++++++--
>  grub-core/loader/efi/fdt.c     |   7 +-
>  grub-core/loader/linux.c       |   2 +-
>  include/grub/efi/api.h         |  15 +++
>  5 files changed, 149 insertions(+), 15 deletions(-)
> 
> -- 
> 2.17.1
> 

Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E325341E17
	for <lists+linux-efi@lfdr.de>; Fri, 19 Mar 2021 14:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhCSNZR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 19 Mar 2021 09:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhCSNYy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 19 Mar 2021 09:24:54 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A518C06174A
        for <linux-efi@vger.kernel.org>; Fri, 19 Mar 2021 06:24:54 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id l18so2541259edc.9
        for <linux-efi@vger.kernel.org>; Fri, 19 Mar 2021 06:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=52RFl4Ac9TgjaukL6s8dW/EmzIaBVmky19n1nsmVds8=;
        b=Ghjj3HVSVrki6RVUdGdjhFDdF83S1SOvYFTRG30jNaApCRBNNEjrHuYByRwLl5WbNF
         3eV22MVxTp0yIvXHZ35edyGWCldXrWG/Jj7Doxzd1whvCSJjEZSYi/YW2m/MJNHixRRe
         2+gowmS81KsPZl7/aYnThdxUC/nDpmA1yM47aJF+xzKToYUONDf87jhwz9SqTzl8SSLh
         UMHr8nsiBtTSNO6ploix0Z1BqEJ5kBp61zXqyGgHcabIJTDpMxfxXR6bHYMauwSd6xGO
         meLiKB+zKI3TcR1toqW04p7SImT+gOwktf7hZe4xr/NbFGEE/oH7nKH3DKIGcC0PmjfZ
         +V+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=52RFl4Ac9TgjaukL6s8dW/EmzIaBVmky19n1nsmVds8=;
        b=Y9yx6I/eSAYUojOkwb9iqpWdejK4zeROc6RFpzz3RXXOY2Aqpc4Ev1xN/FTC9NUQpP
         qF8JjVoIvgwwwA2Joan05pHbFOOZVSbbc/Min8qeLXYYfQFSCfNOAIWpy/nc41vQuIUi
         u5bA4Ab8oXSUDk7EPdJK7oE+UpjLNrNNBltRI1XIy4iFbyfLIBX2NMxIcEBigZOzzBd6
         iYrpOkug0yj5+D2wopQYlwm2BsCFGp0qkjKyw750e5x/KFRZxvvkdLVtHcVgd52kLIpG
         NtnGB+oH9h7tHqrlvfoZGCbbzFHlNkimw77f2HRQ7S9cTIrfD4kx4VLWkJT+B7+X234g
         Jz5A==
X-Gm-Message-State: AOAM530gZlXmfD/goPT9FkkgyhcYrLzweXo2dTgJsll2WosyYOV9GDMw
        sHTsseWw9Qaiq6Sjg5AqYU0=
X-Google-Smtp-Source: ABdhPJxXLUsdrSL+NEdYjDvrPi9wfDrYe54fP+p6y/CY0RIkgBuI1fqDfwPCiwE5dDK8vnEkezw6LQ==
X-Received: by 2002:a05:6402:4407:: with SMTP id y7mr9560726eda.247.1616160293147;
        Fri, 19 Mar 2021 06:24:53 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id h10sm4280243edk.17.2021.03.19.06.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 06:24:52 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 19 Mar 2021 14:24:50 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [GIT PULL] More EFI fixes for v5.12-rc
Message-ID: <20210319132450.GA2752671@gmail.com>
References: <20210319125810.230557-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319125810.230557-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Ard Biesheuvel <ardb@kernel.org> wrote:

> The following changes since commit 9e9888a0fe97b9501a40f717225d2bef7100a2c1:
> 
>   efi: stub: omit SetVirtualAddressMap() if marked unsupported in RT_PROP table (2021-03-07 09:31:02 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v5.12-rc3
> 
> for you to fetch changes up to fb98cc0b3af2ba4d87301dff2b381b12eee35d7d:
> 
>   efi: use 32-bit alignment for efi_guid_t literals (2021-03-19 07:44:28 +0100)
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Borislav Petkov <bp@alien8.de>
> 
> ----------------------------------------------------------------
> Another couple of EFI fixes for v5.12-rc:
> 
> - anothing missing RT_PROP table related fix, to ensure that the efivarfs
>   pseudo filesystem fails gracefully if variable services are unsupported
> - use the correct alignment for literal EFI GUIDs
> - fix a use after unmap issue in the memreserve code

Pulled, thanks a lot Ard!

	Ingo

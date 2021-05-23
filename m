Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0253538DABB
	for <lists+linux-efi@lfdr.de>; Sun, 23 May 2021 11:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhEWJnb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 23 May 2021 05:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbhEWJnb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 23 May 2021 05:43:31 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA915C061574
        for <linux-efi@vger.kernel.org>; Sun, 23 May 2021 02:42:04 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id f6-20020a1c1f060000b0290175ca89f698so9738928wmf.5
        for <linux-efi@vger.kernel.org>; Sun, 23 May 2021 02:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WlmMxL4Mt0uGu2Kyda/F0NtNYk0x06OnN3dZu+3t7DA=;
        b=STBlIvKUhlF/vk0nPZZd3rVYRdOWs5B/pZyUFHkliWmKbJ9baatrZQ1+i8iPdOTMDP
         mzSDSpNRqpP3RbuztbuoARi96Lco1siG8b7nj69RCyqFbsofAoc5QjDsn7UFfp0B7/1X
         ntCfw9Df8Zb2huW32JZhTJR7S290LDKYe/x8iMJrDnoRMtKDtIXqupjkpubICWGc447X
         20FsnbgfDq4h9EjKFi3hYaoY56Xw46dUtgBeEvTc3e5Z6hvLBGXJvvqqQsykd24FC+j+
         1HNQe+YMI42S2JPJR509+rwzp02KeZ5PsPmxqKH56NW8i7560TSsDC+JXxwDxdW04ITm
         8cPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=WlmMxL4Mt0uGu2Kyda/F0NtNYk0x06OnN3dZu+3t7DA=;
        b=KS/ICoPsCZt9abSvpT4j2qd/mDOZfGgpq+ggbvU9Wh6ER5F7qAp2xW0G95fqxyPP76
         IontUgxbJIvmvbbtbJPDj53qimQTpq+/Lkg6Ce1ip626e9FbqqMyWiiwdDhXlCcgcqHk
         i8BXKlgi87l+gTPZRfutdLOGZwTyVsiP7UMKs6LvK1C3KKEfE8Q9LdH1Lj+pQ14FRGTu
         e1F2FUPgia4MZjU9mQvIUlhIv7olFCRXZTIygssKFQ2asAekK1kkZP0MUQQA51hZ062Y
         hEUzmaiYdWd49oAN/XlWKPIImQzsZIh96IBtgSZs4cm+6lcvG1pmtYJ+/xDLIuHKhZvH
         Mp4g==
X-Gm-Message-State: AOAM530uUycNS/30W0SVuWEgcXkMd9GgZiUCBvqol6T7SCinLfVlMaR4
        LAPggthDCpB6hUGiyX2J2yw=
X-Google-Smtp-Source: ABdhPJymwckLWUq2CNOA64jQLRjTDMp4dCF87b4aDG5/HM6Oqjs1+zkDOIBctU75NrdOQ3TFS3lMeQ==
X-Received: by 2002:a7b:c056:: with SMTP id u22mr15752496wmc.181.1621762923562;
        Sun, 23 May 2021 02:42:03 -0700 (PDT)
Received: from gmail.com (178-164-235-213.pool.digikabel.hu. [178.164.235.213])
        by smtp.gmail.com with ESMTPSA id u8sm4494216wmq.29.2021.05.23.02.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 02:42:03 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 23 May 2021 11:42:01 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [GIT PULL] EFI updates for v5.14
Message-ID: <20210523094201.GB1716068@gmail.com>
References: <20210523090413.70225-1-ardb@kernel.org>
 <20210523090413.70225-2-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210523090413.70225-2-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Ard Biesheuvel <ardb@kernel.org> wrote:

> The following changes since commit 942859d969de7f6f7f2659a79237a758b42782da:
> 
>   efi: cper: fix snprintf() use in cper_dimm_err_location() (2021-05-22 14:05:37 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v5.14
> 
> for you to fetch changes up to bb11580f61b6c4ba5c35706abd927c8ac8c32852:
> 
>   x86/efi: Log 32/64-bit mismatch with kernel as an error (2021-05-22 14:09:07 +0200)

> EFI updates for v5.14
> 
> First microbatch of EFI updates - not a lot going on these days.

>  arch/x86/platform/efi/efi.c             |  2 +-
>  drivers/firmware/efi/apple-properties.c |  2 +-
>  drivers/firmware/efi/dev-path-parser.c  | 49 ++++++++++++---------------------
>  3 files changed, 20 insertions(+), 33 deletions(-)

Pulled into tip:efi/core, thanks a lot Ard!

	Ingo

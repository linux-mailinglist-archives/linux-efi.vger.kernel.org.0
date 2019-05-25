Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B19AC2A265
	for <lists+linux-efi@lfdr.de>; Sat, 25 May 2019 04:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfEYCgY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 May 2019 22:36:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42814 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfEYCgY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 May 2019 22:36:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id r22so3475198pfh.9;
        Fri, 24 May 2019 19:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tYxwe9lyS3Xueb1CoeTmlmL/Tl2Z+zsVKsgNJGaaxv0=;
        b=s0a7PgP8w5cvZCwCDzsqV+FB3rhEiyvzQs+dsLvTtg7SX71nHO90rFXJSXJfJutKev
         yPPm9pvO0QEm/2IV4LJ8ntcIYM+wEOkhPy8OTku40Tuq/cE6P0eIpcLn+gGVnK16CtSq
         8FCBgM6sOdwuapNEMKzpgRhhbWrGBk3s6skQ/I2eBfp6bK1E3B9ILeje9AtSyXvn/Tpj
         dv0LZ1Q3WkVVQ1SMdyti2DdfwOJZz6sQOjLitS2bRjuI1pFxYJhSz8c4Kyd7Nuo6JZvk
         3cHu2RJNSMzfEtVXMDhFdYEJEe9NK0Re0abV4DIOqppVv6DB2iUkBeqc2rTVA21E4j/S
         erWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tYxwe9lyS3Xueb1CoeTmlmL/Tl2Z+zsVKsgNJGaaxv0=;
        b=Ua3n17+Un7fSyDXNePFzqSMqtQVB4u3zTOd+GBFw1X1RDlKFdSztbWdXj6AOatWZBd
         ypGsQ2oYCrVngDczn8ZQ+vQBlJ2ulnifthzZnqNAlzq00z/usId5wMeacG5/NX1CnzSP
         lBvc5s8Zsqhns2NtkhScU80RsIo8QLVGEy/4a/9msawInyQSYUTYs35x/FfnCRGvyt4O
         tIO4mWLHdtFXhjRkP8juEK8MUqsVB7dx/nbsiqMja266eH3YyFAruYk949qMU805ZLE5
         i4NuYH8RqmRSImmNG5aB1pM9grJadQtsyH1iFgEE2MLUaOZgTNVW47F+Yg0fWDJZPurU
         D+RA==
X-Gm-Message-State: APjAAAWTtC1D73kuowwsyZ5UGG5luzLRVsUQPSyVTAxR+79MONwO/HqV
        6S5MGKLkXqaxtcx5pZ5qcoU=
X-Google-Smtp-Source: APXvYqw+IMAZlzuenQjEawqQMyOpg9k5Zv152ytwnMS0tVXUvTnjPJzndqx99GLunyxvyY8nk3uUUQ==
X-Received: by 2002:a17:90a:bf0d:: with SMTP id c13mr13869888pjs.88.1558751783875;
        Fri, 24 May 2019 19:36:23 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id x66sm4175682pfx.139.2019.05.24.19.36.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 19:36:23 -0700 (PDT)
Date:   Sat, 25 May 2019 10:36:08 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Darren Hart <dvhart@infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] efi_64: Fix a missing-check bug in
 arch/x86/platform/efi/efi_64.c
Message-ID: <20190525023608.GA11613@zhanggen-UX430UQ>
References: <20190517082633.GA3890@zhanggen-UX430UQ>
 <CAKv+Gu98JNK34Q6MNOe3aq0W5rbv6hUFiuc7cHxHJat5aTk_gg@mail.gmail.com>
 <20190517090628.GA4162@zhanggen-UX430UQ>
 <CAKv+Gu_mwFpdtNZm9QMFn69+vOMTOpv9gvuhnBL2NBXvwkhXqg@mail.gmail.com>
 <20190523005133.GA14881@zhanggen-UX430UQ>
 <CAKv+Gu_wRYZdDYXso0B5m_BPJznGQXpCWq4_0u34bConu0V1ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_wRYZdDYXso0B5m_BPJznGQXpCWq4_0u34bConu0V1ow@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, May 24, 2019 at 06:07:10PM +0200, Ard Biesheuvel wrote:
> Apologies for only spotting this now, but I seem to have given some bad advice.
> 
> efi_call_phys_prolog() in efi_64.c will also return NULL if
> (!efi_enabled(EFI_OLD_MEMMAP)), but this is not an error condition. So
> that occurrence has to be updated: please return efi_mm.pgd instead.
Thanks for your reply, Ard. You mean that we should return efi_mm.pgd
when allcoation fails? And we should delete return EFI_ABORTED on the 
caller site, right? In that case, how should we handle the NULL pointer
returned by condition if(!efi_enabled(EFI_OLD_MEMMAP)) on the caller 
site?

Thanks
Gen

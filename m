Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C0743E5B6
	for <lists+linux-efi@lfdr.de>; Thu, 28 Oct 2021 18:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhJ1QGA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Oct 2021 12:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhJ1QGA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Oct 2021 12:06:00 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD44C061570;
        Thu, 28 Oct 2021 09:03:32 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g8so27159300edb.2;
        Thu, 28 Oct 2021 09:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xx6DFjQoliGEPJ1gZJeqq1Kdphj5UhZhV7Z7AcHT1D4=;
        b=GzNhaGE4IXEOat7m1BLNGU/Yy6jDqWFOFx7/x486X/LmMO6vNrM0u4zSSJIwCoX4lc
         4cAabCtqt7L37O+HAinQD2dQQyvsJm4v3TAdbynBB9cCW15i1J3AQIzT4SLC1uKpQkQx
         JQqzQdxpAZcEzW+B6bseg83dBNzYqrah3FmIAc2I+zyRBKA4exJ3J9vEndJYH9hGmxlx
         h6mpCf7L3hPfoQ2tGs45OuvdgFBUNPu9B1772VfavgZfmURzCpgCFQELn9jKfE7My7bn
         rmO2PgSBaQvsr+ZF7o6agHXaEKUKIfHLocXxTUu9yJUPl9aNLwJhSxrfrd2XRLungOpU
         gCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xx6DFjQoliGEPJ1gZJeqq1Kdphj5UhZhV7Z7AcHT1D4=;
        b=JKgsn1kP8LiJ/3rWLElsU5FLXpK/kSOnpoiwaR14I6JGiyQH26PRgg2DC3szHOS6LL
         CxDI17GL/ixS5vpjyMi+XZeDO5juXcw/Bf38UaYrRLUv4g5pOKqglqNljDoZJBDMWKHG
         oGyE3Hu0ZViaSebWf7mDwAn9y3T9yy4H2OGqPa64o8kaGBzGtNfy7i6Y9xOw2V3+eh8t
         JApLBm/n3vbpJMbb0Z1CCReJ2mPHVUxywpw12T3/6w+Qjvg98Wq4AfM9+2bpYMcMqqN0
         c7kcjS4FnKe3cm4s+lMruEHVpwOe89X5VL/oqKSXkSrOzgV6g3puiffe3i7wqlSESjqa
         YelQ==
X-Gm-Message-State: AOAM532j9RPB5DySt/gAkhjdeMv2Mtp/DJ923aW52T9XzaG67cXNgDXk
        EdHY5usams1Duo15XMaZkexsN5wihqVryFcTR+suJrxRhhg=
X-Google-Smtp-Source: ABdhPJzGah2DxSuKC4EnezTdcUEzqodWk7xG8QjAklq3f5Hihw29B1EIWt/F6OqZb1Xm5jL/dArqOwntUTUNpa2nupU=
X-Received: by 2002:a17:906:645:: with SMTP id t5mr6462018ejb.163.1635437011411;
 Thu, 28 Oct 2021 09:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <20211027195511.207552-1-martin.fernandez@eclypsium.com>
 <8a8e0743-e54d-ec96-da4e-1d101b550274@intel.com> <CAKgze5Z3fT9F0S-mogfP6is9sL3=0imtCbfy6ZYrd3zgaBUqRg@mail.gmail.com>
 <YXq50yzJQqrJk13v@zn.tnic>
In-Reply-To: <YXq50yzJQqrJk13v@zn.tnic>
From:   Richard Hughes <hughsient@gmail.com>
Date:   Thu, 28 Oct 2021 17:03:20 +0100
Message-ID: <CAD2FfiFS++2-Sn5nCft8Eb-R41MM6abCjXyDn8bOVY-_miCpRA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] [RFC] x86: Export information about hardware
 memory encryption to sysfs
To:     Borislav Petkov <bp@alien8.de>
Cc:     Martin Fernandez <martin.fernandez@eclypsium.com>,
        Dave Hansen <dave.hansen@intel.com>, linux-efi@vger.kernel.org,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, ardb@kernel.org,
        dvhart@infradead.org, andy@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
        Daniel Gutson <daniel.gutson@eclypsium.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 28 Oct 2021 at 15:55, Borislav Petkov <bp@alien8.de> wrote:
> > Userspace will just read this values and conclude (as it is right now)
> > if your memory is able to do encryption.
> And do what with that information?

We've got Red Hat customers right now that are completely confused if
they have hardware capable of encrypted memory. We want to make it
part of a specification that can be passed to the people actually
purchasing the hardware.

Richard

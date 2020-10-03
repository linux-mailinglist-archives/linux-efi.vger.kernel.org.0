Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D01328266E
	for <lists+linux-efi@lfdr.de>; Sat,  3 Oct 2020 21:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgJCToe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 3 Oct 2020 15:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgJCTod (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 3 Oct 2020 15:44:33 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4D9C0613D0;
        Sat,  3 Oct 2020 12:44:32 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id 19so5871841qtp.1;
        Sat, 03 Oct 2020 12:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5hUezzo8hUcmZG6E5UAfmoNw5nxRF6WFHj3rv30U5Bs=;
        b=m5S4x6BEp6u4XqhhSv3TOKpm/N6FoVFmOp0DC9/on/dANweIR9vks8AfuVCksRKcML
         buxRVCIdXZpEY++Yaoqy3QlyaXL1q66yI0CQqjvZZvP4nO0lB5mCnVDN05fIqTKrrt2Y
         NcAZGNP8ebkMQPLJhu5GtXuHazwFtL7U2UQP/z+o9Liskwx+7ft6qOaA1auC2z8N0gs7
         7EHlVW9ufeWlLtYeGTq3WIZTKHsewfK7fZ++sa63Gq7inKnECsKKa4msY+iSPmj0ESLA
         uSo5KLCpy9hfKWnw0yFcqsBCVcze+6CbwlVNP8QfC8d1xKa1DS6vXgc42fvWChOoipO5
         VNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=5hUezzo8hUcmZG6E5UAfmoNw5nxRF6WFHj3rv30U5Bs=;
        b=rWvVWp+GzDltee5NskcqumAGTszfUq4ntJRT80OA+vUEvmOI5f8RQz+V2Cw3rvhuHh
         Yd6QkgDGvhDFWDaBhPmoqe01PPdPA+rzsZHumotxfAu7nAiuROjbQCUOZCLGCebeJa42
         +zzEkNBuLVhse1AXH9cJM/FtlSDrpwHlWhwxqGXFEU58lySffW2b76UcLdIGu7Y1Wiz9
         aXU6ljGTKm5u07Z9fpaCta1LKhIPjXfWutXv3UVYRbj+pjLbHNSJ8wiDGF3DcTnSqGPQ
         ANCY8i1sN1oNtEBytEqkIj1Pie1WSnUhMBuAZxchkPOhXE+MtqdKnATULzG5gF5xATXf
         8ydA==
X-Gm-Message-State: AOAM5306XvdRLS4VI46QOZdwcuOLcyLvVgmG141KZdjrwF85WTOO9iBA
        uAvsnQv+MCL+8kbYgdf3YBU=
X-Google-Smtp-Source: ABdhPJwE7Tgts9z7iIMcYd8Oc8lRH9YbkRma2HmxX1HDPzxgJHmyYcIonhX0QBg9WoomtY1fXp384Q==
X-Received: by 2002:ac8:33ec:: with SMTP id d41mr7915646qtb.390.1601754271477;
        Sat, 03 Oct 2020 12:44:31 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c70sm3855038qkg.4.2020.10.03.12.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 12:44:30 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 3 Oct 2020 15:44:29 -0400
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] efi/libstub/x86: simplify efi_is_native()
Message-ID: <20201003194429.GA768061@rani.riverdale.lan>
References: <20201003060356.4913-1-xypron.glpk@gmx.de>
 <CAMzpN2hZ6833u4P=Vr1hueoYCfYryHoTW1dpa-9FTL3nvehJ0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMzpN2hZ6833u4P=Vr1hueoYCfYryHoTW1dpa-9FTL3nvehJ0A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Oct 03, 2020 at 01:28:18PM -0400, Brian Gerst wrote:
> On Sat, Oct 3, 2020 at 2:05 AM Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > CONFIG_EFI_MIXED depends on CONFIG_X86_64=y.
> > There is no need to check CONFIG_X86_64 again.
> >
> > Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > ---
> >  arch/x86/include/asm/efi.h | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> > index b9c2667ac46c..ab28bf1c74cf 100644
> > --- a/arch/x86/include/asm/efi.h
> > +++ b/arch/x86/include/asm/efi.h
> > @@ -223,8 +223,6 @@ static inline bool efi_is_64bit(void)
> >
> >  static inline bool efi_is_native(void)
> >  {
> > -       if (!IS_ENABLED(CONFIG_X86_64))
> > -               return true;
> >         return efi_is_64bit();
> >  }
> 
> This would then return false for native 32-bit.
> 
> --
> Brian Gerst

32-bit doesn't use this implementation: it's #define'd to true in
drivers/firmware/efi/libstub/efistub.h.

Thanks.

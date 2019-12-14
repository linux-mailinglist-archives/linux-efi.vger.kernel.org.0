Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1D7611F4CE
	for <lists+linux-efi@lfdr.de>; Sat, 14 Dec 2019 23:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfLNWOY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 14 Dec 2019 17:14:24 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44307 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfLNWOX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 14 Dec 2019 17:14:23 -0500
Received: by mail-qk1-f195.google.com with SMTP id w127so2241550qkb.11;
        Sat, 14 Dec 2019 14:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mNxH4bC0nj4GKy1qzFOGpsL1EBMNwk7EhK4/inatLcs=;
        b=ILEZNtdmmx/CUHtQBEJSuLuOmeMmonMQ4Gq1TR2xfxGV7Q8RsQ+ySllmBfGH1TBFVf
         LnFaVgqExmdgj7k9KErMQIIlmmFW8rIvzFXvzl/Zzgf9Fm3lDynGykU1NeL3KYEUCm91
         CkeLUYt2AUR3nJzfNE+nna+rly3IsSbpKJRsYHgdOdNUWngwKddkYOinlnIYFyZOsf1N
         VUOEfVZzvwnfbwpnE0r7H11kd+LtFPbqME8nCOK3izp4SvaS2XqajynwZM3b2pAIpIFi
         WPqz8r64PNEsTpCwD6XnEoR/Q7BGpoa/plFcWhzW8c2xSFa0hiVk8yIf0uZ2rC9ripHd
         Sqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mNxH4bC0nj4GKy1qzFOGpsL1EBMNwk7EhK4/inatLcs=;
        b=M52XxHJnr/gAaQ4QvafAwh9z89oNNTW/H0N7JmWVns15oftoDnDIgQGWW2xAC5GPgO
         fZt2XrkSPOIC/v111N9NXLr0VOpcDBjV7PTyRsxMhexYGVhQpJxntWQh3C9832+Dsw69
         ToN2kxEXoEeJrO2Qz4z8ssgNsOgZ1LiWgZgsJvTMsmQXcF3iAmDqrVpwWygxYgEPoAdS
         +29FyRdPpe7NzG2iILoDK4s4LmE+EN99l9XC8pV+YJ5fl7aNAr4vL6mvTDyuLMFZVerS
         TSiSOZZLuw8oMmufv+tLrKGDgP56XhRmEmg/HsVNviGM/QDRSTZeT+wubhi7WWzo0IGj
         jzMA==
X-Gm-Message-State: APjAAAX7aIGG2R+r9i/dBgZfMDFw6zg9dkMOnJ3KlFt/Kk0THlChzzK/
        T2HIMacKDAR3OytuajdC37Y=
X-Google-Smtp-Source: APXvYqyt2uNyrzAsRZWGSIBr1phWC1jzp/BKcUCVuGfbTEZT334tULcotp3l/4PxFNR99raWAnHPFQ==
X-Received: by 2002:a37:4f04:: with SMTP id d4mr12713502qkb.200.1576361662509;
        Sat, 14 Dec 2019 14:14:22 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id d23sm5179142qte.32.2019.12.14.14.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2019 14:14:22 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 14 Dec 2019 17:14:20 -0500
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 05/10] efi/libstub: distinguish between native/mixed not
 32/64 bit
Message-ID: <20191214221419.GA314531@rani.riverdale.lan>
References: <20191214175735.22518-1-ardb@kernel.org>
 <20191214175735.22518-6-ardb@kernel.org>
 <20191214194626.GA140998@rani.riverdale.lan>
 <20191214194936.GB140998@rani.riverdale.lan>
 <CAKv+Gu_JQz=xd_UmqiuZ8TvA+ksT_rY4iXP_j7OdW4F5sfZt9g@mail.gmail.com>
 <20191214201334.GC140998@rani.riverdale.lan>
 <CAKv+Gu-A4bE0DM96-dNjtsYG=a3g-X4f-y=NcJ5ZCvZHaDJZmw@mail.gmail.com>
 <20191214211725.GG140998@rani.riverdale.lan>
 <CAKv+Gu85yLS6cYaGPTLc=hjHjvjjYYX-E0wCwKK+1W+T9dxAcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu85yLS6cYaGPTLc=hjHjvjjYYX-E0wCwKK+1W+T9dxAcQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Dec 14, 2019 at 09:30:08PM +0000, Ard Biesheuvel wrote:
> On Sat, 14 Dec 2019 at 22:17, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > Maybe just do
> >         if (sizeof(at) < sizeof(__ret))
> >                 __ret = (__typeof__(__ret))(uintptr_t)at;
> >         else
> >                 __ret = (__typeof__(__ret))at;
> > That should cover most of the cases.
> 
> But the compiler will still be unhappy about the else clause if __ret
> is a pointer type, since we'll be casting an u32 to a pointer,

Ugh, yeah it complains even though it can tell at compile time that that
branch isn't taken.

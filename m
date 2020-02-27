Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC0D1725DD
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2020 19:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbgB0SDJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 27 Feb 2020 13:03:09 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:34257 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgB0SDJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 27 Feb 2020 13:03:09 -0500
Received: by mail-qv1-f68.google.com with SMTP id o18so14104qvf.1;
        Thu, 27 Feb 2020 10:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LUivbxZvkhrhksfrufImP5WxVz+Lup/2YGlGavTZRzU=;
        b=FECqC/GLqU4wsSzEi4rPTFDzOXiJO4CXOuMOJtQhjaXNpmtMCYY/O6CxZd8c5QeaFJ
         w2nhwZq6DTmOU6dV+/ZPcUSED9y9g0GDkBA3S0rrjNXBxc2YBVthEbkRr30uXl8vLvrk
         RuHejyJlqwMvxy/BOKLS43wSWaqT+byxSShnrrst4a/1zIbiC9g8E5redGQYliesOW5k
         OwgIcES80s3l2Y+WAE3FmaKIVeKUWimW19fXFqnhy4gON87OrMWgI+Zcm6Ru3e+7a+au
         1/W8PlDJ/ogtz3TZ8au57Mkkcs2D83jdIzSG+IiYYSau1Iy39Fyr9QgcF8KBVgDO4MWd
         fztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LUivbxZvkhrhksfrufImP5WxVz+Lup/2YGlGavTZRzU=;
        b=etze2xXSgzQdkjymxx4W0KDHQ2uvI+cXWLNdWIwqluSWUU53fMftpEaUVNbPFDvmXp
         RINUkkePBLmQF8lI1CWQ5fJVn9RukOJplgKk1HSoCxnkPm3oW8vXAogvdpeFtc9v1GCe
         3mQoQ5yTp8OIv0OuqJW3AGhSWD6+/RlGSmNQpFSOo/XvyYjwrdj6iDvY4BMVeZMn8hXE
         BkvG9vNLd7YnX6D6GrQnoKezRfytHo8Og7vKJACisQRdcmsdoDjjiPEzm3MmyaRyperz
         J0aw0ajQCjxuD8Ib0br1Kcf8IlgLkeRF2NYDEbZPWiKevR+WKIEukfwxiWX7ADU0UGc8
         F7Og==
X-Gm-Message-State: APjAAAWz1odKqF/kWf2859XDB7xE6WT3e2cJ2ktEbMN1bL87rYSnhoHJ
        5ePnfqd6Zj0tJ4Yj1/16L/jGUxVL1G8=
X-Google-Smtp-Source: APXvYqyOmOSD5Jm9Upwu1WHPMaefpd6RANzksD5mm3iBpbX9WBw1KKWWevGspvflnOKhG9RICeYjCA==
X-Received: by 2002:a0c:c24f:: with SMTP id w15mr75014qvh.66.1582826588320;
        Thu, 27 Feb 2020 10:03:08 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id m11sm521291qkh.31.2020.02.27.10.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 10:03:07 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 27 Feb 2020 13:03:06 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 1/1] x86/boot/compressed: Fix reloading of GDTR
 post-relocation
Message-ID: <20200227180305.GA3598722@rani.riverdale.lan>
References: <20200226204515.2752095-1-nivedita@alum.mit.edu>
 <20200226230031.3011645-2-nivedita@alum.mit.edu>
 <20200227081229.GA29411@gmail.com>
 <20200227151643.GA3498170@rani.riverdale.lan>
 <CAKv+Gu8BiW6P6Xv3EAPUEmbS3GQMJW=eRr-yygRbForaGDQyyw@mail.gmail.com>
 <20200227155421.GA3507597@rani.riverdale.lan>
 <CAKv+Gu-k0c8GzKysv4Z9tYzEvfhJUzuiKx5nfwD0JU8ys=LZdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-k0c8GzKysv4Z9tYzEvfhJUzuiKx5nfwD0JU8ys=LZdg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Feb 27, 2020 at 06:47:55PM +0100, Ard Biesheuvel wrote:
> 
> Interesting. I am going to rip most of the EFI handover protocol stuff
> out of OVMF, since it is mostly unnecessary, and having the PE/COFF
> loader put the image in the correct place right away is a nice
> complimentary improvement to that. (Note that the OVMF implementation
> of the EFI handover protocol does not currently honor the preferred
> address from the setup header anyway)

Yeah, for my testing I'm running the image from the EFI shell, which
enters via PE entry point and honors the pref address.

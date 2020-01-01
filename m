Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFE112E041
	for <lists+linux-efi@lfdr.de>; Wed,  1 Jan 2020 20:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbgAATIr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Jan 2020 14:08:47 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44291 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbgAATIr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Jan 2020 14:08:47 -0500
Received: by mail-qk1-f194.google.com with SMTP id w127so30057032qkb.11
        for <linux-efi@vger.kernel.org>; Wed, 01 Jan 2020 11:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I1xS7cOwk6Opc2LvJv/55e8/p8ij2zcJsMERIVafiNo=;
        b=ZDE8N2Bp+3J0mp8m07Yw1347bCkOuOtYSh1pWifKfoE26Smw1Np69EeJZq+Hb56c6h
         aejZe8uOedXJ8hTrLHACOxMbu72UnSlbHsY3ZLQKU57d12TwxZlETX70HEwdoEWE4fFY
         pYR8uH1qB3ZAffiD9csiFIxFw9636zTPimfU8Gij/GjSThtQjclnvoP1XBKE6Nq6xRAy
         EOUnHgEEom+fxTU7+IxchS0X/JXZNfbycB9hiyC+897jeu8Y3Nk3pyyCer+Fbq8T8Oho
         fQ5deA6aAN6BueswjC2vBkVaVISnGIHTSRnlY6rbmk2+2kwepvL8FxkfxZYn3unA3R7I
         Oqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=I1xS7cOwk6Opc2LvJv/55e8/p8ij2zcJsMERIVafiNo=;
        b=DE/LoIbvGjDhT6IJBXaPzRsQQDItcbfv/FadhvMIMeCWQI18r9HRaT5O/1/mE4KfCl
         L6By3HuHgs+4xEKhAMYljRUPLDG4IAg9owa1B8LuJ9uGX5fhbvoL8sQk3Cgtc/ns5A+s
         8tl6Bh8hpp7nB1ep+sGjO03Fs13h9jWSPbp1yEaayOME53qQhTInoPaq58LoVjcdqOxp
         k0cRfjM/QWE3jzZm+eF+0UhXl3ckRH/a7pGXTTA6pmK1UxodwCvj45Q+zsTPM9q+1ZQe
         OjwlqpS/q8PD2QWlnfARsa38cU1Jrg9MvLOpzIgTh897p2fCfrgcnhheqnyuchRIraVq
         uDig==
X-Gm-Message-State: APjAAAWlqyzesZToRDR+2r9zRpzzAFQkXr4zd6cKlMHYQD2nLVEd/pFZ
        EOLiEQ8bkYHMsnWWLCjgQaQ=
X-Google-Smtp-Source: APXvYqxthd2A996CGpwQJEQ2W7q6tPzSLSZjLqhChLssRMwPbwOcvh0azjZudhUeBUQipeWqjOQZJQ==
X-Received: by 2002:a37:52d5:: with SMTP id g204mr65791416qkb.215.1577905726325;
        Wed, 01 Jan 2020 11:08:46 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id b42sm9958326qtb.36.2020.01.01.11.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 11:08:46 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 1 Jan 2020 14:08:44 -0500
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 13/21] efi/libstub/x86: drop __efi_early() export of
 efi_config struct
Message-ID: <20200101190844.GA208136@rani.riverdale.lan>
References: <20191218170139.9468-1-ardb@kernel.org>
 <20191218170139.9468-14-ardb@kernel.org>
 <20191231230436.GA78532@rani.riverdale.lan>
 <CAKv+Gu_6zKX9vtvJ9r_CMfufh9-0yOJikYH-Z2xtVcn5i8qwsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_6zKX9vtvJ9r_CMfufh9-0yOJikYH-Z2xtVcn5i8qwsw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 01, 2020 at 07:13:45PM +0100, Ard Biesheuvel wrote:
> The GCC documentation mentions that it does not make sense for a
> function annotated as const not to take any arguments, so I'd rather
> avoid it here.

Where does it say that? I only see it saying it doesn't make sense for
it to return void.

Currently if we call 5 EFI services in the same function, it has to
re-evaluate systemtable and is64 for each call, which seems wasteful,
though of course this is not exactly performance-critical code.

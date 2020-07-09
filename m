Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19AE121A448
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jul 2020 18:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgGIQCS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Jul 2020 12:02:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbgGIQCR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 9 Jul 2020 12:02:17 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFB3A208C9
        for <linux-efi@vger.kernel.org>; Thu,  9 Jul 2020 16:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594310537;
        bh=K45DJ14e/pHYHlhDRXMB06y45U/dqxzjDYmEbXO0t7Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Pf7UXbU5lI9fMgrjIppWAZNBiQBJ/ELPGJrwqbOK9P0wrNZbvFk/HlQd8hDDHBVDn
         mgfmVUHcng5qIeI+42c4TRsXfdOxCMAhCnMNiWPoxfzMU/nx+GwhNpHxKUbGZ6KMAL
         fUMiKYOWX6VmX4AOqQ1B7DApro0HpdFHj3K9QDDs=
Received: by mail-wr1-f45.google.com with SMTP id r12so2925037wrj.13
        for <linux-efi@vger.kernel.org>; Thu, 09 Jul 2020 09:02:16 -0700 (PDT)
X-Gm-Message-State: AOAM533t5Kf2//iJO5/nXxMMjLIDf+Jcgq4nrEXiuUHHmwWMnRYE+LSA
        ppr/vBEmyJCxkhs4vZDsjnk8tncYlcwaiVdVuxBDkw==
X-Google-Smtp-Source: ABdhPJxzRIFsc7By7VMCeEO3c+cA7oBIQu77SztDLFlUnbln1kuZgDgGF2rnT8p5T+DVTINyww/KaQgNkWN6aCLZjCI=
X-Received: by 2002:adf:f707:: with SMTP id r7mr63065788wrp.70.1594310533334;
 Thu, 09 Jul 2020 09:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200709145447.549145421@hpe.com> <20200709145448.652996700@hpe.com>
In-Reply-To: <20200709145448.652996700@hpe.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 9 Jul 2020 09:02:01 -0700
X-Gmail-Original-Message-ID: <CALCETrXo9gTR0XWQ5e-YoRryyvJ3tuOaOVB+DyF5OUNRpfBteQ@mail.gmail.com>
Message-ID: <CALCETrXo9gTR0XWQ5e-YoRryyvJ3tuOaOVB+DyF5OUNRpfBteQ@mail.gmail.com>
Subject: Re: [patch v2 09/13] x86: Remove efi=old_map command line option
To:     steve.wahl@hpe.com
Cc:     Jonathan Corbet <corbet@lwn.net>, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oliver Neukum <oneukum@suse.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Benjamin Thiel <b.thiel@posteo.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Young <dyoung@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Austin Kim <austindh.kim@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Russ Anderson <rja@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jul 9, 2020 at 7:55 AM <steve.wahl@hpe.com> wrote:
>
> As a part of UV1 platform removal, delete the efi=old_map option,
> which should no longer be needed.

Can you also update kernel_parameters.txt?

--Andy

Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C29012B0B2
	for <lists+linux-efi@lfdr.de>; Fri, 27 Dec 2019 03:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfL0Cmj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 26 Dec 2019 21:42:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:49614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfL0Cmj (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 26 Dec 2019 21:42:39 -0500
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50F2F21582
        for <linux-efi@vger.kernel.org>; Fri, 27 Dec 2019 02:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577414558;
        bh=RqBzHw1Da7EHw/XgG9QSxt2ewvpc9OTWM8falsxytA4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aaz8lXErRLqQaFKyvgeK+L+k8q1TW/h11MKDm/xEpuMGdVX0SxLyX1iZDdpwL5bDd
         23q+3LyJ+ePsBC+O6M/6lOUKwF4gaMlt20xdB/sRHcOKpVW2wMNTJ7RaDbFs4xkJgM
         3qiBiehsGNqQ1IIFOWHWFXCmEOtMkcJT6aKwLa+E=
Received: by mail-wm1-f50.google.com with SMTP id p17so7299961wma.1
        for <linux-efi@vger.kernel.org>; Thu, 26 Dec 2019 18:42:38 -0800 (PST)
X-Gm-Message-State: APjAAAU1oGY/ZrWjB+UcA/Ec/oUWTz6Nno0gT7YumugqsXu/Ad8X/b1V
        eKDfQzNVCX9RdDx6cVRp/Iroo4EuJn5EFCGGqwHu+g==
X-Google-Smtp-Source: APXvYqz0xrPL+C8t4d0ZDYmvUU+XWVHobGvjA8zzlerjYnA2Pq3Ui6SOkVbTmNIh7Igj62mBh+emCsCeOJBEYEQgKFU=
X-Received: by 2002:a1c:3dc3:: with SMTP id k186mr16090192wma.95.1577414556779;
 Thu, 26 Dec 2019 18:42:36 -0800 (PST)
MIME-Version: 1.0
References: <20191226151407.29716-1-ardb@kernel.org> <20191226151407.29716-2-ardb@kernel.org>
In-Reply-To: <20191226151407.29716-2-ardb@kernel.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 26 Dec 2019 18:42:19 -0800
X-Gmail-Original-Message-ID: <CALCETrVmF1CmEDVChMSG2QtEwHXZ6N_g66WENeoJX-69yeTUFQ@mail.gmail.com>
Message-ID: <CALCETrVmF1CmEDVChMSG2QtEwHXZ6N_g66WENeoJX-69yeTUFQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] efi/x86: simplify 64-bit EFI firmware call wrapper
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Dec 26, 2019 at 7:16 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> The efi_call() wrapper used to invoke EFI runtime services serves
> a number of purposes:
> - realign the stack to 16 bytes
> - preserve FP register state
> - translate from SysV to MS calling convention.
>
> Preserving the FP register state is redundant in most cases, since
> efi_call() is almost always used from within the scope of a pair of
> kernel_fpu_begin()/_end() calls, with the exception of the early
> call to SetVirtualAddressMap() and the SGI UV support code. So let's
> add a pair of kernel_fpu_begin()/_end() calls there as well, and
> remove the unnecessary code from the assembly implementation of
> efi_call(), and only keep the pieces that deal with the stack
> alignment and the ABI translation.

FWIW, you also removed the CR0 save/restore.  This ought to be fine,
but it might be worth mentioning in the changelog.  (At one point,
CR0.TS was dynamic on Linux, but these days it's always cleared, so
that part was presumably just a historical wart.)

Reviewed-by: Andy Lutomirski <luto@kernel.org>

--Andy

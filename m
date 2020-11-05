Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34752A785D
	for <lists+linux-efi@lfdr.de>; Thu,  5 Nov 2020 08:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgKEHze (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Nov 2020 02:55:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:52842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgKEHze (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 5 Nov 2020 02:55:34 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B85F21D81;
        Thu,  5 Nov 2020 07:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604562933;
        bh=ILQsgNruhKDt2vPDw/jNHb6v8iE6SdKZAJxgT0uFkVs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vm7wDrZtH8hCZZhvbWldGAC8JkAXrTIBAL+/sKUAbfT0a3u/kuqxe9vqsEoBRPBG5
         A9z8nxFvjErl5yxH2rZUeMolxekaQ0tmMNJPHqiu7F3COIC7AdbHiQmQUuG8w6M8aE
         J2djvof8dx5XYWt931eCmxS4RcajC5JdiQsMDJao=
Received: by mail-oi1-f178.google.com with SMTP id w145so775687oie.9;
        Wed, 04 Nov 2020 23:55:33 -0800 (PST)
X-Gm-Message-State: AOAM533vk9NxI0mwwiR2he3k6RnXy/wHtgIm73fqwh92XPMNfO+E/1At
        ynt7INMsMy2S9gUTQDUHOhanLUa1ktjVKGpbph0=
X-Google-Smtp-Source: ABdhPJz0s48E0Uvx/LbM4nWjUD81saxN86YiaP7mZgwrihee0KkZSuk+iCMwoI2P6rp0m0uR0CBa4QMNdSLVkanFInU=
X-Received: by 2002:aca:c60c:: with SMTP id w12mr876218oif.174.1604562932577;
 Wed, 04 Nov 2020 23:55:32 -0800 (PST)
MIME-Version: 1.0
References: <20201102223800.12181-1-ardb@kernel.org> <2fd203414ba8ac3349f0109fea633838b4e04f05.camel@linux.ibm.com>
 <CAMj1kXEjKt0F8dZBnF=x2ShkxyvoGApXzVA-HMCY2oOj7kuKKg@mail.gmail.com>
 <c044fc25be309e7b25a4c64845fd753515c84804.camel@linux.ibm.com>
 <CAMj1kXFuHTruFRudKT512Cmj35KJjcJkTfeHtEjVbfCUZ6oBFQ@mail.gmail.com> <cee4fc79d7918a764b75a7bc38cd6323f4704086.camel@linux.ibm.com>
In-Reply-To: <cee4fc79d7918a764b75a7bc38cd6323f4704086.camel@linux.ibm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 5 Nov 2020 08:55:21 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFQY-khbopEV8N2NvOakya3XXXquxDCKS9j51C1=GJd+w@mail.gmail.com>
Message-ID: <CAMj1kXFQY-khbopEV8N2NvOakya3XXXquxDCKS9j51C1=GJd+w@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] wire up IMA secure boot for arm64
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Chester Lin <clin@suse.com>,
        X86 ML <x86@kernel.org>, "Lee, Chun-Yi" <jlee@suse.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 4 Nov 2020 at 20:55, Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Wed, 2020-11-04 at 20:12 +0100, Ard Biesheuvel wrote:
>
> > > I do not have a problem with this patch set being upstream via EFI.
> > >
> >
> > Ah right. That is probably better, as EFI goes via the x86 tree, and I
> > work closely with the arm64 maintainers on other things as well.
> >
> > Please let me know once you are ready to ack this from IMA pov, and I
> > will carry it further.
>
> thanks,
>
> Acked-by: Mimi Zohar <zohar@linux.ibm.com>
>

Thanks Mimi

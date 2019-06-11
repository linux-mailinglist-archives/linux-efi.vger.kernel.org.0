Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66C453CDE5
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jun 2019 16:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbfFKOEt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Jun 2019 10:04:49 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34679 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfFKOEt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 11 Jun 2019 10:04:49 -0400
Received: by mail-io1-f68.google.com with SMTP id k8so9999403iot.1
        for <linux-efi@vger.kernel.org>; Tue, 11 Jun 2019 07:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lqiV0H/q9eXS4pPY8ifFtwx91fWhcQXdqFfEPZLTdQo=;
        b=eUtJcz7kMzQNsi51loJSdWD05S0bHEOKf0PxE6aQVntLz281nYy3TJ4EMAOxtpDVL3
         ndf7w5pBzShfAa7NyLIFwXXxOZWNlu8Gyin4oHHZVQsyvb1NnMZxn7CpdITj22zG/IfO
         DCjEqgWRNJMD8DTcAz+GhzuIg+AM8obANPmWyQcSpGUCv+zEroQph640p+cLh/JhS+T1
         Mn4qb9KYmNG8bCplBuq3our6DHBmM9pgKINJ26OzUgcKsg2RPI/mEd5dpqGcxj8ujyIb
         Sn5Ycs32hcDG9W1cK/EjKfa2ql+YFQa+tjjH6Emyt2/nrrDsekbpe3/c5LedxtR9eI84
         ANQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lqiV0H/q9eXS4pPY8ifFtwx91fWhcQXdqFfEPZLTdQo=;
        b=cNqRzNNljN8dVvCQllY6oRW0GKrLL+NICPszCpCUAZ10g9iDnQd8EVhhmBEekM6OM5
         IJvPntqEs6I7aTp8eOOjGuuAVBGVwldfD8qVNSMAkMVukyv0VyhGWW8F+pxfYVqzioGP
         GABTSifyanwjqJoICgQhGLZ+uilsZk2EsA/gWdp3tUnRDS/ZIcx6q6ivVTZS6HycsQtB
         ljF4HAZN7h/zjFYic+VgjPoOLgKf0a5CG+h1w73p4/bVlm40eBJlNbdlD7+0/e4ZvRvF
         zXQX/9yd3PPgB3oqz2C7aOifIMeHxCpTXTMg47A87SXAien2Iao4Of1rSf63O0oLxlyi
         mHWQ==
X-Gm-Message-State: APjAAAV0QWnGuG4EiXrlCe/C+S6zdmRRud6x7WNvRGqq1+wz4gcsvPVF
        Tu3fqSoNfkyEuuOS62a7sDCjRgLcQwtal2GcrfifRg==
X-Google-Smtp-Source: APXvYqw3LRmAkOB3ftFk4yMEDVpReE2Imm5Cqt58r31GxBysK1n5qJ/Bi+jXKdTRBFe/XTjFGtBUaC60P2Pgde1TZs4=
X-Received: by 2002:a5d:9d83:: with SMTP id 3mr41608629ion.65.1560261888654;
 Tue, 11 Jun 2019 07:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190529154635.2659-1-hdegoede@redhat.com> <CAKv+Gu8bLcDROFNFfqHaN1Z+EK5bnXMNDSJbBK-pCmq5XP_kBw@mail.gmail.com>
In-Reply-To: <CAKv+Gu8bLcDROFNFfqHaN1Z+EK5bnXMNDSJbBK-pCmq5XP_kBw@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 11 Jun 2019 16:04:35 +0200
Message-ID: <CAKv+Gu8w2Vj-AS-cfaB8cms+ZJ7qppS-Du_334_xm51rz0CYsA@mail.gmail.com>
Subject: Re: [PATCH] efifb: BGRT: Add check for new BGRT status field rotation bits
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Peter Jones <pjones@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 10 Jun 2019 at 17:12, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Wed, 29 May 2019 at 17:46, Hans de Goede <hdegoede@redhat.com> wrote:
> >
> > Starting with ACPI 6.2 bits 1 and 2 of the BGRT status field are no longer
> > reserved. These bits are now used to indicate if the image needs to be
> > rotated before being displayed.
> >
> > The efifb code does not support rotating the image before copying it to
> > the screen.
> >
> > This commit adds a check for these new bits and if they are set leaves the
> > fb contents as is instead of trying to use the un-rotated BGRT image.
> >
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>

BTW should we make sure that this patch and the efi-bgrt patch get
merged at the same time? I guess the net result is just that we get
rid of some error in the log, but a rotated BMP will be ignored
otherwise. Or is it relevant for userland in some other way?

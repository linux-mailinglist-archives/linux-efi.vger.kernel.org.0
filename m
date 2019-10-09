Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55380D0F81
	for <lists+linux-efi@lfdr.de>; Wed,  9 Oct 2019 15:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731233AbfJINC2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Oct 2019 09:02:28 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40808 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731187AbfJINC1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Oct 2019 09:02:27 -0400
Received: by mail-wm1-f66.google.com with SMTP id b24so2509807wmj.5
        for <linux-efi@vger.kernel.org>; Wed, 09 Oct 2019 06:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6gKyU2lVUG9r8tkVXQwlslVrnGaZcT+vH7d3AbPHYB0=;
        b=GHo82XUApFZmoJ9rbUiaxY0lPH5g1hfz9r8MSUnSI3GN9JdNoZQcA4UQ6OJo1rICO0
         qzfEEIaPLpbItb/8PbB0tgtmMY3OvSBeFhFZiL7aO0dIhyWBySy0Gc4iZkpX6vcuzMon
         Wj//7wE6Nd30Th7JDUX9ivMJk8/CkfEoL9COKkOw/OLGxaSlPBMlO4GEdXfniAHaK+uV
         ThL1YwwiUvNrQ4RoX+Gkqtnk4np+XvZsHPcUah8iL/Z2af9/saPP/imUSPit0/RkYjkD
         lCQnoyj1ClCApdV1FAhLZTizqvX7pcIkRlATP26I2RICqhtg4PmooQaeKNBqRXA5MyyA
         j92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6gKyU2lVUG9r8tkVXQwlslVrnGaZcT+vH7d3AbPHYB0=;
        b=OQL07PcO7Eep0qlWUm4rEC44Xr+SDeLevgRDlcPeC3Hvw7uCJEao9fJk8OkHG6jdq1
         P0w2pCRTPtRr58R18F+NbsX5uAV/6yWJsY/546TwzY2ugYl2BwgHXnhvUe/3PfwiDBBb
         ELjFePjCc1ufOjGhX5Xtn3PzzSbF8Kd8LiS5+vgYahyEHoYes0GTV9rtJoHcf1Rfx0/x
         tc2PZBR4LorgYpo5kp3fM1QW82tdKClddRDdkFW0nPMAY25HU8BgxAf0UhRRvHqq5GK1
         jqdBJ5AiWNOaqYZaDszRYl1R01/kqmEdJEuN794vUD0VKwuwN3LDcFMJxrSJhkaWD6eT
         VCKA==
X-Gm-Message-State: APjAAAVU30BigVkggpEtO4icvrS84xrgfV5riVGGKkjDbqVh0g8bNg/k
        P2XN/1VtZmeapS/fDnRQRIjEmc54tmdXe347Wu109A==
X-Google-Smtp-Source: APXvYqx+LxYtjcQzWODIZ+2Z6/00LXRbD8qwCw7fnhTtTZ7OXnXpkwtdFXmQrWSQSDmS0fILF/nvqqpHFCBNgF8/Vuo=
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr2412915wmj.119.1570626144905;
 Wed, 09 Oct 2019 06:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <20191008105510.6975-1-javierm@redhat.com> <CACdnJusuMQf8B9u83mB2Wye+aZ4aV8v4j2eFrokURHkLGA0G_w@mail.gmail.com>
In-Reply-To: <CACdnJusuMQf8B9u83mB2Wye+aZ4aV8v4j2eFrokURHkLGA0G_w@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 9 Oct 2019 15:02:13 +0200
Message-ID: <CAKv+Gu8xgqEqeRPQSyEkcW6q0rosFRsGNdDxfOL2QdQXzkKvWw@mail.gmail.com>
Subject: Re: [PATCH v2] efi/efi_test: lock down /dev/efi_test and require CAP_SYS_ADMIN
To:     Matthew Garrett <mjg59@google.com>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ivan Hu <ivan.hu@canonical.com>,
        Laszlo Ersek <lersek@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Josh Boyer <jwboyer@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Micah Morton <mortonm@chromium.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        James Morris <jmorris@namei.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 9 Oct 2019 at 04:18, Matthew Garrett <mjg59@google.com> wrote:
>
> On Tue, Oct 8, 2019 at 9:55 PM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
> > Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> > Acked-by: Laszlo Ersek <lersek@redhat.com>
>
> Acked-by: Matthew Garrett <mjg59@google.com>

Thanks all. Queued as a fix.

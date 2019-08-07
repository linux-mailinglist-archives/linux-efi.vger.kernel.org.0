Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6FD285643
	for <lists+linux-efi@lfdr.de>; Thu,  8 Aug 2019 01:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbfHGXDQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Aug 2019 19:03:16 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:40888 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729219AbfHGXDQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Aug 2019 19:03:16 -0400
Received: by mail-ua1-f65.google.com with SMTP id s4so35675067uad.7
        for <linux-efi@vger.kernel.org>; Wed, 07 Aug 2019 16:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p3wiUZTjk/4U/E4pi4Y2n0i/U7m5LkR3wRuzR1Bth2Y=;
        b=c+/0SXYFPNw46NRsWE6P91sFVLXR191WhfFGez4Z3L6n/kCMfju/P3OvTcDT7nRng3
         0DuVP6bypyJOpVZ3IQ958+wa5TcdHu5wj3SXO68gguTLGCfdkE0N6fNDDCH/C0C/icTu
         zMDbE1BFA0vpE0vWfBFgXLw8BErTXhA0SqRtCFfj57LGnKIkmn+s28lYbL3tKpB1m/bc
         Fh4mZMRGRnoyPRvGpfK7PTLyHYUab/HWZS3QPrtEDHb03rSBrsm0OAiqd5hIbEvE5n3V
         qIwGH13ycXp5Mu2bO8eNOtQ8CdnqT8j0Ypz3UyKmcb66GGUmdvsdjg1umBh/5bge05XR
         O+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p3wiUZTjk/4U/E4pi4Y2n0i/U7m5LkR3wRuzR1Bth2Y=;
        b=F/sbhY40KPWVE1O6Psp6FXiEMjdSRnKHB4aNK6HxNvqEqlbtAHR9gPev4aXSL90s3E
         ICx788dMSn/iO12yeSAZz/IGOpeuwTJtlkLAAloDEopbg+6E3CPETIKkFkmyqP++E25f
         /VQzFqEba9x6rtZncnQs5w6/eOMzqinF+nb9p0ndWsKzCRLGhXoETa2Pu982v1sLthwk
         uVRnL04ptX8a+QZrH8bfrZzZ7UWJCCb1aedAb+c54kGHIv6XIkPfNVmuxCdBMUzIqVfo
         /bjGYNVLQBLcL7TwRI6+pUSS/SvhAJGNXiclb1f27xbEesQ+1Vnx0PyAw6lVU29I30Z8
         Mx8Q==
X-Gm-Message-State: APjAAAVOdI3da2r/MqCkIAvPe36FMvT53t7rRQ0tSf1qfTL87hb5iwOP
        0KF33GMwCKFKLtWImqQAUZK1Os2+AxFbCAfZb0H0FQ==
X-Google-Smtp-Source: APXvYqxCbzuMBWT5K3b2HgUi+Q5hTzul8JsyZgTT6hLJtDr97u7KeHt/RxokKus6SftJ2PcCZHaoSSck3FX5mjKavTU=
X-Received: by 2002:a9f:3806:: with SMTP id p6mr4441649uad.21.1565218994663;
 Wed, 07 Aug 2019 16:03:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190807215903.24990-1-hdegoede@redhat.com>
In-Reply-To: <20190807215903.24990-1-hdegoede@redhat.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 7 Aug 2019 16:03:03 -0700
Message-ID: <CACdnJutiu0kUreyECpNok=D1hPqCW-JDw1aEzMU9cMuTSiMTxw@mail.gmail.com>
Subject: Re: [PATCH 5.3 regression fix] efi-stub: Fix get_efi_config_table on
 mixed-mode setups
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 7, 2019 at 2:59 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Fix get_efi_config_table using the wrong structs when booting a
> 64 bit kernel on 32 bit firmware.
>
> Cc: Matthew Garrett <mjg59@google.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Fixes: 82d736ac56d7 ("Abstract out support for locating an EFI config table")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-By: Matthew Garrett <mjg59@google.com>

Good catch. I think fixing this is preferable to reverting - the
duplicate events are visible to userland, so there's a risk that apps
will end up depending on them if there's a release that behaves that
way. Presumably mixed mode isn't a thing on ARM?

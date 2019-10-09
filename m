Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4D1D0571
	for <lists+linux-efi@lfdr.de>; Wed,  9 Oct 2019 04:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbfJICSN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Oct 2019 22:18:13 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44473 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfJICSM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Oct 2019 22:18:12 -0400
Received: by mail-io1-f65.google.com with SMTP id w12so1427371iol.11
        for <linux-efi@vger.kernel.org>; Tue, 08 Oct 2019 19:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4hyGtFYQiv1Yn2S99OC7OoYmGIdFfpfcg76zXN+1O3Y=;
        b=Gnew97C5M5yGW/IiuM0QLHj0r5iu55tSm2w3gnj7nyhTPvpXtQqgXoF1APoicmjttU
         BNk0UcPk27kaLkEoBuGe17L0agFA25MI3EEqxPB5UQKfwLFx/j4BAdlQCqYIdTs2nh6e
         W1sR3OFYPix2B7HPTCEK5STbbjZie8TQRxF4lWze8F3UcrIGUF2JatMtJqfVFaKnfoPU
         7MIMk1Qy21npdiqE1WnHb/tU91fSwGXuKg7t6kUFibog33yNyHedj8SLmPdW/XOdJKPh
         SaYFtG4N/f2p4m43nIK3JLlWcgExOzsQi24KpdWujcGq41XO+peLEX9d2yyve4hJQmU0
         /UBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4hyGtFYQiv1Yn2S99OC7OoYmGIdFfpfcg76zXN+1O3Y=;
        b=D0Zbfh55Q8JcgkqWM/WWuZrXeCmGMzeUnWVOXGHQQGOzzioy2W+wmhirwlgefVnu/Z
         l/b25H4oeG5A0cjTBRTHsLey1SPOUqKVEz/DD+Url6Azoz9WQefwt3MLGHU3tbbgn/HX
         Flgrja+Fkwp759IlPoC+RPzKduOjA+raXfy0fbDuMd56/ZkQ5XFjj+ygMKtpUtmg+vEV
         +gHZGyk9idpIQ1LQ3ICs7j32uRo7w19gs+im4HJdgyMGMUtyl4tkdeV6zwL6+fiURlb1
         lchBB0HuRexnv2rvM+A5ISJPntfUz8AKs913eP5LCnz0Tck8+dv73nkjdukInh8DLUVU
         +u7g==
X-Gm-Message-State: APjAAAW4b7tgZT6hRLCxf7AN8k6o86NteLQoUnKui/XhrJAJ0Z6VRa7R
        qCl50fkUT8yu5LRN4hR+ycx9j5Yybs4H1kWORxBvNw==
X-Google-Smtp-Source: APXvYqxwIKqW27ucq+a99beZjsiBvn75o81k2oBEjZ8B324EAdi/ExE2N+8ycBcM6VNVXQRWrQHX8aH6ykb/yNfK5JA=
X-Received: by 2002:a05:6638:2a1:: with SMTP id d1mr1074617jaq.103.1570587489682;
 Tue, 08 Oct 2019 19:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20191008105510.6975-1-javierm@redhat.com>
In-Reply-To: <20191008105510.6975-1-javierm@redhat.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 9 Oct 2019 13:17:58 +1100
Message-ID: <CACdnJusuMQf8B9u83mB2Wye+aZ4aV8v4j2eFrokURHkLGA0G_w@mail.gmail.com>
Subject: Re: [PATCH v2] efi/efi_test: lock down /dev/efi_test and require CAP_SYS_ADMIN
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ivan Hu <ivan.hu@canonical.com>,
        Laszlo Ersek <lersek@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Josh Boyer <jwboyer@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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

On Tue, Oct 8, 2019 at 9:55 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Acked-by: Laszlo Ersek <lersek@redhat.com>

Acked-by: Matthew Garrett <mjg59@google.com>

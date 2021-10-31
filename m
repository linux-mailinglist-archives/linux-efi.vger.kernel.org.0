Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253684410AC
	for <lists+linux-efi@lfdr.de>; Sun, 31 Oct 2021 21:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhJaUFH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 31 Oct 2021 16:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbhJaUFG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 31 Oct 2021 16:05:06 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D67C061570;
        Sun, 31 Oct 2021 13:02:34 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w1so3679568edd.10;
        Sun, 31 Oct 2021 13:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zfUaTO+JtpEhn8e4kj/WNJyyw6O24RYn0R5mAg+QdhM=;
        b=j6yxrxbDE14KoLZW7mKUm9ai+b0gD2eNXHdKpe13a9Q1L9XfF1lf/SNxtTIiQ1mpeH
         zzfPPYgAqNvB7eY54qFYk4ym006xjZlWOlfjDI1W1IThs35MT7BNn2oMvkUlJ73iBc8m
         Iz6MHWPjpEozS6gyb6UfTrWAo3CyDVHWC2OLpKTDFruOaZpGMg+QyJq+WzgKOs3+MAti
         ziZgcnJg+caLAPjNLmrfwwSTkkw1N7+eXuweRy9CVXh9XyMaT52UGPueaOCV9LMV6SP5
         eNQZ1pH8od0FleHRKIlU+vxIiVVf89P46D1R5BRD4UPgjhEVSByFN8S3XVPwWqeojpps
         /5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zfUaTO+JtpEhn8e4kj/WNJyyw6O24RYn0R5mAg+QdhM=;
        b=lwznTYzpPypjSOwe0qbl6MRuZVO9V9JwEqauwfC1pJ1kcPNVvf12UFuMqTBCZBFwLt
         HH1vmtK0nMYv2XtNyTXL1YajxvPuNoXUDAA3nrYbsOgqP0i2ZoukfD6EhHcBz7AtrYGT
         0eY2bwxwgZ7pYLwiHUfyr7jKhhEs074uT9T6691oMT4cKdV2Sy/gaWbz5HpZGZU4z/PM
         +6JSTPgczWYh0GdtPfEkC8ClyZrXy2NNtSl5mBqEy/924PkM5x9oqH/+08rYD8hWLCuk
         80Y4IFCKDQ/Pmb8w01V9BULNRcY3onsu3yByzu+mV8CNaOXhQPn5u0X7v9MMf2YYBupq
         Hqfw==
X-Gm-Message-State: AOAM530ayWPM9j/WLg5zonxob3fPAN0sIMJYpLQ+LKKEk3M6AzCu1aL1
        VHvee0ytLqq50EKtCIVU1ts9eTkKMQgDeI2dIF8=
X-Google-Smtp-Source: ABdhPJwQcLdE22O0BD2/YnkE/eji2qmfxqA//Hdb2+Oq/NgFgzZ7imVt7Rxdj9HTRsd98Aq8oJdclTKupG7J+V1oe/M=
X-Received: by 2002:a05:6402:10da:: with SMTP id p26mr34696434edu.283.1635710552671;
 Sun, 31 Oct 2021 13:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <20211031162428.22368-1-hdegoede@redhat.com> <20211031162428.22368-4-hdegoede@redhat.com>
 <CAHp75Vf-EOfF_XfqfWFQZNLp3B03o79xHf4bUrf9x9D9pTrvgw@mail.gmail.com>
In-Reply-To: <CAHp75Vf-EOfF_XfqfWFQZNLp3B03o79xHf4bUrf9x9D9pTrvgw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 31 Oct 2021 22:01:56 +0200
Message-ID: <CAHp75Ve-WAQM0aLbhRzyT5KQ-tej17=nczNSY9hG5zXztmRVWQ@mail.gmail.com>
Subject: Re: [RFC 3/5] gpiolib: acpi: Add a new "ignore" module option
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Oct 31, 2021 at 9:59 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sun, Oct 31, 2021 at 6:25 PM Hans de Goede <hdegoede@redhat.com> wrote:

> I'm wondering if the idea behind this is something relative to
> https://elixir.bootlin.com/linux/latest/source/drivers/acpi/sysfs.c

Missed line:
https://elixir.bootlin.com/linux/latest/source/drivers/acpi/sysfs.c#L792

-- 
With Best Regards,
Andy Shevchenko

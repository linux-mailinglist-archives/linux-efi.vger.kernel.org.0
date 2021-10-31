Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCAC440E73
	for <lists+linux-efi@lfdr.de>; Sun, 31 Oct 2021 13:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhJaMzV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 31 Oct 2021 08:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbhJaMzV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 31 Oct 2021 08:55:21 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6269DC061570;
        Sun, 31 Oct 2021 05:52:49 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bu18so13856717lfb.0;
        Sun, 31 Oct 2021 05:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KsU6C8DCbzTsNFFfktVF1wri/7sdYIU4HQYUbAWLagc=;
        b=PhslQAKvrpeIN7feHYjaT5Px4ASWnFZP1fd1o0IpUunKpikQj842qisdh07HLB74Iy
         +4tGrRWCvDG2rV5CDp5eA6bZ310HUXb6vtZfp98kFUnTEPlRpTL24qpi6l/iaMlg+jWZ
         DjYjQUy0//T74C8jPP0cr9BffYT8HwbznZ5ccT+pW7pJPRVsq0ia1QN4pwDxTNz5dcHr
         vrV95BTa2gZym8+wBR222hBgJBK0bLKgGlyqgpA5zpQxL8hhbxh6s01/1//ouL9Ju57H
         1zgshTF8xcfZwKSepeqn5E1uvYMaMedTR4Ukvrx3WrWHOaGB3Cvg3tzIcjafR9eQdWfB
         iKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KsU6C8DCbzTsNFFfktVF1wri/7sdYIU4HQYUbAWLagc=;
        b=O13/7zCjlVGlzoL/1OIedA0cKiFs3zHozZyVs0yBRnyRd2vDOmjDaXqcAGgJFrkI1+
         7hvTzJ7bs43JZ55PdOxxLosAPZg4iXXAA9w3eIHl5IKkxhFz6haj2sVxDJHsrOzRHt5C
         HRnhhJjtHepQ1BA3FaqqRLs3zIvCuiLj/24RBZ52RppJk5SVOwjoUHch4XK/umP7z1nD
         kIeEgHHjb41BLjZe1fDQBAIY3DvX7q3fJt5/qWXZ2+FE8LFXO+fBtsn05y36FaKfSwim
         PcOC6epQXSHnQRUPJIXq8d73LzE0BpHPuDTwe9Eq+f6uEPRFnIKMjcQ3Xyb9yAZj3RxS
         jWGQ==
X-Gm-Message-State: AOAM532ZyzNI1CpqU4Tz/2aUzdZylQsknOrPiA8vjwAFVDygvxW2LwL6
        aOXqeqsdQ5JTQKc3MweA/0eRsl81fIBrAjznjHM=
X-Google-Smtp-Source: ABdhPJzKIgyiS9xupKWX+ht1y8HzbkQ9S2BGp5QpsvkwXuwzgDgydBnU1hAMgz/1QNnxMJSFj38Hdmd26EuI/eqD7VE=
X-Received: by 2002:a05:6512:acd:: with SMTP id n13mr21685799lfu.60.1635684767624;
 Sun, 31 Oct 2021 05:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211030182813.116672-1-hdegoede@redhat.com> <20211030182813.116672-14-hdegoede@redhat.com>
In-Reply-To: <20211030182813.116672-14-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 31 Oct 2021 14:52:11 +0200
Message-ID: <CAHp75VfRALjbGaY8rdt5HCte3_NPuwpdkr+GNZV7qMWBK1idWg@mail.gmail.com>
Subject: Re: [PATCH 13/13] extcon: intel-cht-wc: Add support for devices with
 an USB-micro-B connector
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>,
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

On Sat, Oct 30, 2021 at 9:29 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> So far the extcon-intel-cht-wc code has only been tested on devices with
> a Type-C connector with USB-PD, USB3 (superspeed) and DP-altmode support
> through a FUSB302 Type-C controller.
>
> Some devices with the intel-cht-wc PMIC however come with an USB-micro-B
> connector, or an USB-2 only Type-C connector without USB-PD.
>
> These device are identified by "intel,cht-wc-setup" = "bq25890,bq27520",
> since there is no Type-C controller on these devices the extcon code must
> control the Vbus 5V boost converter and the USB role switch depending on
> the detected cable-type.

...

> +       if (ext->vbus_boost && ext->vbus_boost_enabled != enable) {
> +               if (enable)
> +                       ret = regulator_enable(ext->vbus_boost);
> +               else
> +                       ret = regulator_disable(ext->vbus_boost);

> +               if (ret == 0)
> +                       ext->vbus_boost_enabled = enable;
> +               else
> +                       dev_err(ext->dev, "Error updating Vbus boost regulator: %d\n", ret);

if (ret)
 dev_err()
else
 ...

?

> +       }

...


> +               /*
> +                * Classic micro USB-B setup, this requires controling

controlling

> +                * the role-sw and vbus based on the id-pin.
> +                */

-- 
With Best Regards,
Andy Shevchenko

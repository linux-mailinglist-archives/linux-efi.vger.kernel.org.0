Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6C143813
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jun 2019 17:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732588AbfFMPD1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Jun 2019 11:03:27 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40514 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbfFMOX2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Jun 2019 10:23:28 -0400
Received: by mail-io1-f65.google.com with SMTP id n5so17264199ioc.7
        for <linux-efi@vger.kernel.org>; Thu, 13 Jun 2019 07:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YOkGT1KIxTydfc//oUhWW5qv+v1zc6TApVXVTHnuiBk=;
        b=u9W4Ip1SP17N3CMFC0jAgqw3/YCf1mjljApAKab6FyIk/0lSaR9QRCtVuXQBJPoce4
         HxaxZd0q32m4aA1vZj2VX3h3IyI7P/rcbwYk13PXuJsSlv6rWlKioMkguiV/92+5nBRF
         F9SzazSY7gdyB5ZiVWlbxAS219PzVwSFyYOhmVr/xrBp3xGihlpgQXGsEsit8B8qDjbU
         AP470YMK0ikMrhW4bGl8U8ZmYJHjIrfUn6B9uAvo4fs7DpFTR0bdPf2/tI5Qphy1HO8Y
         7l6lnvoTCOI9rci2G8fSYjp/z/Z1/Sa0KxaV7qbMksPAzPiaVHoFQXPG63mMFRGdwt+r
         aAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YOkGT1KIxTydfc//oUhWW5qv+v1zc6TApVXVTHnuiBk=;
        b=hItlaR51qXHSBdscrZDzwdflPrb5usT5qGRdLNe5/YTmq+XCZtiNQOsY4s3g40pV0c
         KOjctcKtSdJ6pESQoSnzAL3mOLgXC1OQGaf2HDx34nouCWjuhSQJDzWmgX8r+j2YTJk1
         SZhN6FLsKrcV8H/wtI+bpRLqWgk/3LQ42OEmzsxc64DfnbPuvDMi6dbLZ7ClQNNDtqGQ
         v1qEewQbuF7Ng7kqp9fCEA4aqRniVCWFFmLLewDnkNGiVvFngbM0eghSTCQRumXShh06
         +LtyqbsQP4KEK4i6dr44WlTfy1j+MRZzSNSAwENIVXBbm23YvK9/G6qQad8/bCDu+L1w
         VsJA==
X-Gm-Message-State: APjAAAWlUhBs2bdxHDfVFZ1NFnbTA6ceJ8nCqyIcl7lnvafX13P0CSKZ
        erZIglRckkIHlWqdher7mUWvxWem0W0Otm432ILxyw==
X-Google-Smtp-Source: APXvYqySOWyS2ZP9Mgdhpfz4IsLEVqbSwM6UU/jOunxH/EWnFp0zHvdh9z5miYCq61vyXmCSTiFJ0K46W0yL85439jA=
X-Received: by 2002:a5d:9d97:: with SMTP id 23mr4599191ion.204.1560435807048;
 Thu, 13 Jun 2019 07:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190607205147.102904-1-matthewgarrett@google.com>
 <20190607205147.102904-2-matthewgarrett@google.com> <CAKv+Gu-Vz8OSspw9RdEnVj3e7GFaNdA9PVVMWY2RKkEDfAbuRA@mail.gmail.com>
 <20190613140643.GE12791@linux.intel.com>
In-Reply-To: <20190613140643.GE12791@linux.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 13 Jun 2019 16:23:15 +0200
Message-ID: <CAKv+Gu_tacPw-71bgC7WMgSQvN28kWujdmfCgTT5WESF0e=f8A@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] tpm: Don't duplicate events from the final event
 log in the TCG2 log
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Matthew Garrett <matthewgarrett@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        =?UTF-8?Q?Peter_H=C3=BCwe?= <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-efi <linux-efi@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Joe Richey <joerichey@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 13 Jun 2019 at 16:06, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Fri, Jun 07, 2019 at 11:11:21PM +0200, Ard Biesheuvel wrote:
> > Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> Ard, is it cool if I include these to my next TPM PR along with the
> other Matthew's changes? Just sanity checking given that crossing
> subsystems...
>

Yes, that is fine.

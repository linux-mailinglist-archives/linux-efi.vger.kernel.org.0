Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3E04DD25
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jun 2019 00:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfFTWAu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Jun 2019 18:00:50 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43599 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFTWAu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Jun 2019 18:00:50 -0400
Received: by mail-io1-f65.google.com with SMTP id k20so754297ios.10
        for <linux-efi@vger.kernel.org>; Thu, 20 Jun 2019 15:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q1L8uRv2O5Sf9Nnxuq5fcmvqea9J+FoKGX/eSZPI9YI=;
        b=nMD9yr5qiweWh1Lj7LZj1ylEbvr5Ei8RKKNYbfaQCHbkH8r3fxz8fbn3+I3TC79oT4
         K7ubsATwWtEbYTngqJDoZ7gqd44WiCWyOHJ49UY3o7Y6CFjBnlkppSuZX19Ax30cmibc
         r7KZYTqrIwkBaSK177hShJ/kwf6fzypVpcF0LB5FsrfkPC25ZVp7dKdy/Cc1Gs4pV1WY
         rXobPmwDjq8RhCh89WNhuUeb4GsTsN2On5UtX/xLHzugz3cnLg0MatEJ2DT3+QpeK9AH
         5x+2UAq4KXYjTNSLV/gEkxi6TT9NreFJNO/6k66BmKK8Eeyslb90Dmj8TORHWrG8nKyp
         plRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q1L8uRv2O5Sf9Nnxuq5fcmvqea9J+FoKGX/eSZPI9YI=;
        b=snfhM57p8wHBu6GPNbE+eEZBnW11UY95V4ipclpT0wV6Yok5zqJu/8MnYwoFxw4I8d
         6zUVYMpwkwufyVw5I1ju+gCio/PqvAM7aUDa9r/9//8SKBrHSLud1MoSwMeFloCwLNT8
         +gXnCSZRfxHZ5uZENkmk8+/MIHB0nfpm5A2kZLqc/vheRUrq71dnVA4m1SaDQOdXSnoU
         39zPoTkuGmDW7n1A8jrqM6nrn4i7eHZ2vsEIqwS9nw7z3ge1IYpTjUDsSu+g8RZvidp+
         N6FE7BoJ15oltc+wIEWShV5CL9rwTivHJmiKRiYQWqHrbNmSqLa6WLRZ1P+1nyBUuAud
         ul+w==
X-Gm-Message-State: APjAAAVu4rQHKVQmVAK1NV5ND83dhTeMycwurJrNVzIX9iwo4KJug9HH
        gcv5D04t+LR2MmSXgQf1Gf5FuaDJ5FKEGLjrI0jR7w==
X-Google-Smtp-Source: APXvYqyrvNV0TAI2T6wKLb6CUaIt2peexavbbYTFmWo2/dmMyrc6AdQDx7XOB8ftB7s+gWh0AQgHtNlirFETQ42BIJM=
X-Received: by 2002:a05:6602:220d:: with SMTP id n13mr13392720ion.104.1561068049041;
 Thu, 20 Jun 2019 15:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190615040210.GA9112@hari-Inspiron-1545> <CAKv+Gu9-wiJNxPsVn06dBSU8Gchg8LjV=mi0cThZUWywmt2xzQ@mail.gmail.com>
 <CACdnJuudmE-MNuO7z87Mm65VaXbRzhOrBEpU5F=yC67uSLytGQ@mail.gmail.com> <20190620213722.GA17841@linux.intel.com>
In-Reply-To: <20190620213722.GA17841@linux.intel.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 20 Jun 2019 15:00:37 -0700
Message-ID: <CACdnJusDaGkTAEWJ41+dGQxRWqxbgk8a_iNq5pCuGp=NsdEXgg@mail.gmail.com>
Subject: Re: [PATCH] drivers: firmware: efi: fix gcc warning -Wint-conversion
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        tpmdd-devel@lists.sourceforge.net,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jun 20, 2019 at 2:37 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
> Right! OK, I squashed just the fix to the earlier patch. Master and
> next are updated. Can you take a peek of [1] and see if it looks
> legit given all the fuzz around these changes? Then I'm confident
> enough to do the 5.3 PR.

All looks good to me. Thanks!

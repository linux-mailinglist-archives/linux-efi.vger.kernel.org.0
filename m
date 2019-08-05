Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10D15823AF
	for <lists+linux-efi@lfdr.de>; Mon,  5 Aug 2019 19:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfHERJ4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 5 Aug 2019 13:09:56 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38195 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfHERJ4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 5 Aug 2019 13:09:56 -0400
Received: by mail-io1-f65.google.com with SMTP id j6so1175521ioa.5
        for <linux-efi@vger.kernel.org>; Mon, 05 Aug 2019 10:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=018C6jHlTx5pLyIhrEjm9kpmOgEmjnR9kBk7qmzQVkM=;
        b=H6GHYM7hzdKYPL2c+tZTMPNJU+8m2+VmnqBloTMUkI5NH+LGmDItrmwuUYW3z2qsX8
         624aAL4XC0Yq3vNVcF5dvCwZretsO2Uy1UX7NPLM8UmQ3lG8ixxdMHMU+LzcnqfZH2MO
         TwypQXIMwHpbnO1i81xPU+GwzocZRJPpjqFYJ+OJ0+THd4Pyab4Z7bHh3cS4yyDLlcSu
         ivZfijBYylYD9JQs+3isnBJpCotFSDdJ5gZihp8NIvIm7KMn0w5LLhOht7TGr6/7VqzN
         nGnd6yvfOMXo9SRLcHq+Gum9cJcx4st5Uu/hyPXTd0iFAPaFOo4KcJuTgWGscHTXVp4x
         2WrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=018C6jHlTx5pLyIhrEjm9kpmOgEmjnR9kBk7qmzQVkM=;
        b=YjIl0Jc3ZLognO+8QVB01EbkAJmhFX7s6vHEP//SwDFr0T3DcJLlVpaKWu8b3Hrs55
         arkTKkncxPUetbIZZechTCdgggsOVhVbCCr05hV/lf4d/YghEu2zFMfHDU1mJN3kTVWl
         APUp2LgJ2jpXgnW0ufpVkCd8y7hAzVVaYVuR4XOxLLQyYtO62V48L/mbvhEsYOQfiuSH
         L1leHaU7qxcrwmdqfERwMEJOEOQEiyXNcPu5mETe1qhp8AWMSR42EJKMwrFi0V6H9BlU
         c2/o1259aBqR/UCL8QzvtwiJzyAVoUWs+OuSQVHPDcamcjklw6/w+c8H8RdbGZewPxko
         WV+A==
X-Gm-Message-State: APjAAAWurzxnlTwDNkYZZy5k0Z6zed8skz8x1MASpGVp7kz5kLbyPISr
        BueN5qQJv7WwQ6OhGlC7x4IX0vdLU1n3e3PGuKvpHw==
X-Google-Smtp-Source: APXvYqwUIDoOPzK/UGhFLeOEw0eLzgrCZBa6U/bBdYFAisisQYms4Qs0WnkPy0WoviQxJJROLL6VBUpmsq7e/Q4Zjvk=
X-Received: by 2002:a02:cc6c:: with SMTP id j12mr109429024jaq.102.1565024994837;
 Mon, 05 Aug 2019 10:09:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190805083553.GA27708@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190805083553.GA27708@dhcp-128-65.nay.redhat.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 5 Aug 2019 10:09:43 -0700
Message-ID: <CACdnJusRUnhmOLdowqbGoM9Z-tWsKrhZ8sFfQUUmjyKmRVN+vw@mail.gmail.com>
Subject: Re: [PATCH] do not clean dummy variable in kexec path
To:     Dave Young <dyoung@redhat.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bhsharma@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Aug 5, 2019 at 1:36 AM Dave Young <dyoung@redhat.com> wrote:
>
> kexec reboot fails randomly in UEFI based kvm guest.  The firmware
> just reset while calling efi_delete_dummy_variable();  Unfortunately
> I don't know how to debug the firmware, it is also possible a potential
> problem on real hardware as well although nobody reproduced it.
>
> The intention of efi_delete_dummy_variable is to trigger garbage collection
> when entering virtual mode.  But SetVirtualAddressMap can only run once
> for each physical reboot, thus kexec_enter_virtual_mode is not necessarily
> a good place to clean dummy object.

I agree that this isn't necessarily the best place to do this in the
kexec case, but given we control the firmware, figuring out what's
actually breaking seems like a good plan.

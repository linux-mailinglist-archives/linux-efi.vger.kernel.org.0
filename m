Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D913EEE54
	for <lists+linux-efi@lfdr.de>; Tue, 17 Aug 2021 16:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239976AbhHQOTQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Aug 2021 10:19:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237687AbhHQOTL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 17 Aug 2021 10:19:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91AC360FA0
        for <linux-efi@vger.kernel.org>; Tue, 17 Aug 2021 14:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629209918;
        bh=gMQfKofVN+8ENIyL8UFXJIRX/HJ66YgMG0/EAE37kU8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HEpOS7qRLWcGsLl9SPdSU168838Y787DAgcT3I3GyDX4GUa5Y+6QOBOMOe7TLweY6
         QJ70fH6y2DtWXsIjKQzHiolb0nJhctqm9PqZt/fWiYuETXtaUvtLgKyREebER9d066
         YbR5CqmAKmlMItaENIPB1BdT4jtyM6D5B564uQ/EnvYd3kmvkBL5aHPVQVny0p8at5
         gfLewed37usyTpyV7ORB7vbPAdK/joMNqEyKJrczxMYsrOla3PYJm1oWZkXhnX/UzG
         4NjDAId0QS/LqXdVDgtlymBno6fDFsdTT8Tv/oVr0gPUpYVBGcdPjOdUOplkvfelsT
         NvN7axwvUBe0w==
Received: by mail-oo1-f43.google.com with SMTP id f33-20020a4a89240000b029027c19426fbeso5950076ooi.8
        for <linux-efi@vger.kernel.org>; Tue, 17 Aug 2021 07:18:38 -0700 (PDT)
X-Gm-Message-State: AOAM5301wyfEIksVm7uUXwheTq62rE7cu0yORGN9nZsXASP8F5QTrerb
        YQwW7fM480LyCRs0cO3sH8Pn0EJp1SY1/xNRnfs=
X-Google-Smtp-Source: ABdhPJwiet4lYSGuT0LK94Qko4lKt3wM0+E3NoNhg6yOVWHTt9wEAT2igjOx4N/nTQhqZUeQmxu54zXm2jnqPtYcVbc=
X-Received: by 2002:a4a:e923:: with SMTP id a3mr2778437ooe.45.1629209917946;
 Tue, 17 Aug 2021 07:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <DM8PR11MB5750A89EC67DCDCE8DF7366ABDF69@DM8PR11MB5750.namprd11.prod.outlook.com>
In-Reply-To: <DM8PR11MB5750A89EC67DCDCE8DF7366ABDF69@DM8PR11MB5750.namprd11.prod.outlook.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 17 Aug 2021 16:18:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHEcGp+Rai_M6TLSAO03TAA+93PFn1Sxo0gpJwZEzUwrw@mail.gmail.com>
Message-ID: <CAMj1kXHEcGp+Rai_M6TLSAO03TAA+93PFn1Sxo0gpJwZEzUwrw@mail.gmail.com>
Subject: Re: Typo in file include/linux/efi.h
To:     "Han, Jing1" <jing1.han@intel.com>
Cc:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "Shen, Xiaochen" <xiaochen.shen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 9 Aug 2021 at 17:18, Han, Jing1 <jing1.han@intel.com> wrote:
>
> Hi,
>
>
>
> In this file include/linux/efi.h, there is one line in comment as below:
>
> * "NONE" is used by efi_recover_from_page_fault() to check if the page
>
> But there is no function named efi_recover_from_page_fault in kernel.
>
>

Thanks for the report. Patches welcome.

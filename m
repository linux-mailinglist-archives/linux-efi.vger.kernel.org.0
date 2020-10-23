Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92EA297025
	for <lists+linux-efi@lfdr.de>; Fri, 23 Oct 2020 15:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464415AbgJWNQK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 23 Oct 2020 09:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S464414AbgJWNQJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 23 Oct 2020 09:16:09 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F45BC0613CE
        for <linux-efi@vger.kernel.org>; Fri, 23 Oct 2020 06:16:07 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q5so1519976wmq.0
        for <linux-efi@vger.kernel.org>; Fri, 23 Oct 2020 06:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ymaoNpx4USYAYf0RlnokRrq8EkLmaYPAour0/EZLefE=;
        b=1l8gO+qVPtkcsJAgBWpwXY2Ou+/T/9yHUpwunV3G0TdUQFh+wjo4I/rBGok1pVHRj9
         OjskioNp62Rstn+cWouVnQrkSSaCKyc2/lQSYaL9YWwL6sO8pwud/NWn8sbm+1sL7IlG
         /EO2q9qiHAhizRsFHdtjWlzwTLp78j/ucHDS+HfNYwZ1LgAleSb24cNKCDdEspd5WVVH
         C0OCmFOHUgEtwS7OqCTjFXfSkJoHRKZVYWefKZchiR+yjKEuS8YncI/TFgJxopnJZFcc
         xmunV2VW13pLKxmYlLyybud3NVsVwyfjUrE+OTFFeRQ1AkWBMVeOPkaAyfZMZ4AZLo9z
         i7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ymaoNpx4USYAYf0RlnokRrq8EkLmaYPAour0/EZLefE=;
        b=hdLKxarbtwT3lKmxCC2xu6KyuDhFcF6GWBhdNlyXKvZR6u7CXapTAeuLtXohhjkhhK
         I6Dif+69rAHc9rDugT+r/PT8LOPuGZD8ffUQiPKqIBR/JcTVEZIY62rjWgdnjJXRXndW
         U48P8UXy55YwJozEHIUgrg12XjOzxlVOv3rgstmdQ1m2grgnJXpWit0UMokRHK0oN7tR
         201pTwpC9oSq+Nlmt3kINj+tL7k2Ov+R4QnUoeFgCA2SV9sx6ugN1pA+WFUNz7X7rwba
         DQKPR89IATspLlzeVxyacWh4pRr77HHtlaK8UOHMV9yHO/mQgizNrypaTDrHO+J4CYyK
         0CKQ==
X-Gm-Message-State: AOAM533VM3UouLlug6KU8NLpAa/XHZC9SLLRKLZHqsn/FDopR8qM9APx
        ulAG5hjdJBsofUsZPFUrsFXU6wAjNg99DA==
X-Google-Smtp-Source: ABdhPJz6j87/SGAA2x0ENcFWH767tcP8PW2eqSAoL+gQ1j9BXLaTDQ2V3C4acWX+Q/Dz3FXmwXYXcQ==
X-Received: by 2002:a7b:c149:: with SMTP id z9mr295448wmi.0.1603458966343;
        Fri, 23 Oct 2020 06:16:06 -0700 (PDT)
Received: from vanye (cpc92880-cmbg19-2-0-cust79.5-4.cable.virginm.net. [82.27.104.80])
        by smtp.gmail.com with ESMTPSA id l3sm4533342wmg.32.2020.10.23.06.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 06:16:05 -0700 (PDT)
Date:   Fri, 23 Oct 2020 14:16:04 +0100
From:   Leif Lindholm <leif@nuviainc.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>, grub-devel@gnu.org,
        Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH 4/4] linux: ignore FDT unless we need to modify it
Message-ID: <20201023131604.GF1664@vanye>
References: <20201023120825.30466-1-ard.biesheuvel@arm.com>
 <20201023120825.30466-5-ard.biesheuvel@arm.com>
 <20201023124710.GD1664@vanye>
 <CAMj1kXFKSf0HVxLt1GdqeuErFH+r-=NxTnPV7TYjg0b-9hXj7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFKSf0HVxLt1GdqeuErFH+r-=NxTnPV7TYjg0b-9hXj7w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Oct 23, 2020 at 15:12:50 +0200, Ard Biesheuvel wrote:
> On Fri, 23 Oct 2020 at 14:47, Leif Lindholm <leif@nuviainc.com> wrote:
> >
> > On Fri, Oct 23, 2020 at 14:08:25 +0200, Ard Biesheuvel wrote:
> > > Now that we implemented supported for the LoadFile2 protocol for initrd
> > > loading, there is no longer a need to pass the initrd parameters via
> > > the device tree. This means there is no longer a reason to update the
> > > device tree in the first place, and so we can ignore it entirely.
> >
> > There is a change in behaviour here which I don't think matters, but
> > I'll call it out anyway:
> > If there was ever a kernel out there with an EFI stub that depended on
> > a chosen node existing in the DT, and the one provide by firmware did
> > not contain one, that setup would break from this *if* it didn't use
> > an initrd.
> 
> I checked the Linux source, and the original code contributed by Roy
> already contained the logic to create the /chosen node if it wants
> there already. So we should be fine here.

Excellent. Then, with this information now in a public archive for any
unfortunate souls doing anything crazy non-linux to find:

Reviewed-by: Leif Lindholm <leif@nuviainc.com>

Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261B046C3E9
	for <lists+linux-efi@lfdr.de>; Tue,  7 Dec 2021 20:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236561AbhLGTt3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Dec 2021 14:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236490AbhLGTt3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Dec 2021 14:49:29 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C85C061746
        for <linux-efi@vger.kernel.org>; Tue,  7 Dec 2021 11:45:58 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id v138so384686ybb.8
        for <linux-efi@vger.kernel.org>; Tue, 07 Dec 2021 11:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2MSneKG+T5ZjFsWvdBHkKcc61yLnH/4zmInamMFTcOc=;
        b=XRkVTCiWO1xz/EgHSVzeCjqGeOiyHM0C+EN8gqsD/GqXB68KIB5RbhVg6sQb4LCb3u
         MRNmBwVVRaoAZ/Q8jvhNx0e/VxiN53KcjnypA1l69bDxHGLdgaPSd2GEhJowXsz53FKl
         I+zyjV3nz4SgF+4McKTXS6Nj32UMfk04IS1TsLBkMasy3mRiOg+KHMPOh4QpyZJIwsRq
         0ZyNf2090Jdx/gL/0XHDt5WWeVpPXHocZB1Ad8FOBYIdcEGqn1l6V2KsGrvXH2ApiBjs
         ArsNfqlOy7/hXZXncjsZCbJHFeVHPFLaUAE6TNcwsPZ45P3l49H/Dp4cQZHVTqKb8Mfa
         avhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2MSneKG+T5ZjFsWvdBHkKcc61yLnH/4zmInamMFTcOc=;
        b=snaexLDGrLsAmmSUdmN945zQTZLryELt12D5LAH9/fQsQMsGjM7wjskfn8lwiPUsEB
         huxnShzHjo41mdsuE4hyJfMj4UdKT1+aQOld01d6YuqcSQDn2vihQstrJ4LVkq1sBdF4
         xpbGlVBnkn4WQn3YWOKwcb0pm5kYgSpl85MQtbIHHrNUEKjscSTtJ+GJ3JHOWlImlXbK
         R7e4jwOiDLawNgrv75h38k1NJx3aKtvb0I28wHurBelzPNt8ZD32ZXJ5xUTUCpqdT6LT
         p11OlMrS+OVDKH7KAUMy+d59p5zOtNlopt8kzMraFANpnZ+bmp+T38365Nfe9dsvbcRt
         iKhA==
X-Gm-Message-State: AOAM533piJeGcUUbjs3Yprmw2CMyfKdP8baxpe5gSfkEL9HHXjhSbmmF
        TQruOEK0NG+bxnbDMixSlu1IgDtm9nB6VyyV1M27ew==
X-Google-Smtp-Source: ABdhPJyMqHWSV5GGCftCDu/HHVqZSiWmTiUYcfhsLUySuKeO9UuAqLyCDwSql+GLxl0eiomj1NdDabqRlTah2chxdy8=
X-Received: by 2002:a25:c8c3:: with SMTP id y186mr53620558ybf.20.1638906357546;
 Tue, 07 Dec 2021 11:45:57 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a0d:c906:0:0:0:0:0 with HTTP; Tue, 7 Dec 2021 11:45:56 -0800 (PST)
In-Reply-To: <Ya8MUOKPOKVfBfjJ@kernel.org>
References: <20211203192148.585399-1-martin.fernandez@eclypsium.com>
 <YaxWXACBguZxWmKS@kernel.org> <CAD2FfiG9wfeW_2xxZqBi9vsjzEJBRjJUZw+AQy1Taos4fh2TLA@mail.gmail.com>
 <Ya8MUOKPOKVfBfjJ@kernel.org>
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
Date:   Tue, 7 Dec 2021 16:45:56 -0300
Message-ID: <CAKgze5Y6F40bk=PgoS3LshcDEAreefOmF4xpCuSxgpiSr+99Kw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] x86: Show in sysfs if a memory node is able to do encryption
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Richard Hughes <hughsient@gmail.com>, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-mm@kvack.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, ardb@kernel.org, dvhart@infradead.org,
        andy@infradead.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        alex.bazhaniuk@eclypsium.com, alison.schofield@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 12/7/21, Mike Rapoport <rppt@kernel.org> wrote:
> Hi Richard,
>
> On Mon, Dec 06, 2021 at 07:58:10PM +0000, Richard Hughes wrote:
>> On Sun, 5 Dec 2021 at 06:04, Mike Rapoport <rppt@kernel.org> wrote:
>> > On Fri, Dec 03, 2021 at 04:21:43PM -0300, Martin Fernandez wrote:
>> > > fwupd project plans to use it as part of a check to see if the users
>> > > have properly configured memory hardware encryption capabilities.
>> > I'm missing a description about *how* the new APIs/ABIs are going to be
>> > used.
>>
>> We're planning to use this feature in the Host Security ID checks done
>> at every boot. Please see
>> https://fwupd.github.io/libfwupdplugin/hsi.html for details. I'm happy
>> to answer questions or concerns. Thanks!
>
> Can you please describe the actual check for the memory encryption and how
> it would impact the HSI rating?
>
> I wonder, for example, why did you choose per-node reporting rather than
> per-region as described in UEFI spec.

Some time ago we discussed about this and concluded with Dave Hansen
that it was better to do it in this per-node way.

This is the archive of the relevant discussion:
http://lkml.iu.edu/hypermail/linux/kernel/2006.2/06753.html

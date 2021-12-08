Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C40D846D50B
	for <lists+linux-efi@lfdr.de>; Wed,  8 Dec 2021 15:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbhLHOJW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Dec 2021 09:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbhLHOJW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Dec 2021 09:09:22 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01ADFC0617A1;
        Wed,  8 Dec 2021 06:05:50 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id bn20so4030676ljb.8;
        Wed, 08 Dec 2021 06:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rCf0zyvgJUgHg9QQB25FrOzOLqjtx+dGIHtF5AhWskA=;
        b=Gay56VR7oXKZ61yYW2z5K9QvoVrW8L89rA0ixltHr5LjGbLNoA7io0bF8zKsp4DmjP
         jQs7eK//M3hBdOAKMU5QrWIjUIsILYd3JOHIqsakVpSG02LOm3AoE7wG9SuqPFHl2lMW
         XA/SbblXvb53io8vSasL5T1gXSlD7jefkWrMRwM0vTwc+0SjvFUNg4xmGBUpq1p2xwql
         153GBe2uYprCMRfnaX5osln0KFPbNiqxvfE5cXxvIRrRAgO3wQ/yIB53bmDyFmz6Cqhu
         EhXnwiithZcIGYmOupnyy2O57ghT5wCGXPYxGpZmZt5ZFh1VXjBjDI6pCEouXVbUFC2E
         ocOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rCf0zyvgJUgHg9QQB25FrOzOLqjtx+dGIHtF5AhWskA=;
        b=6Lzq/x/np6nwwPh1pvgLFD5oVPwKkwI8ctoC0CtbQdj9BzZE4NNZR6nlJWVIq4pr3D
         I2oxtrAwW4QvXaDjfwoAccSIIQDGFVXjLrqGr0lKuAhZ3mjee19CmIUb/vNBnNPnAh4K
         JZXGvealfQx+Jc7yH1SO9EzoxtcyPTCmdQSZN+sJvBXRjVRSF8zhq1SA5E6ycYCsqFpG
         TY6PmY54oe8/eThNuotTZVXUjWt4jMKhojyyU0SpvtEBzxqxBWQ+wzI4OTBGnVuBVk3j
         IUv8Q/LBuASOAzMpLP6BeQqRpH7i5KscGAMcaMeBqAHRSsoYa9cCO1m/XEkF0HH0+BjO
         sXGw==
X-Gm-Message-State: AOAM5331u6PmNK8mEwRirbmVyEWVdEMiB2JYLO/Qk8SsLpnyYTMEj1DK
        t9aDZCBVTlCWgEsYGZfvO2nQbN4rOBxhJy1ML+w=
X-Google-Smtp-Source: ABdhPJys22p+Nc7f14LfW5nZDfZN5sz0n/uzhuiDoDWANW0u5aCKvBxr4DDNPOGZvcC51LciLgu2KkgeaVdwfkOPZ0M=
X-Received: by 2002:a2e:bb98:: with SMTP id y24mr47069192lje.315.1638972348282;
 Wed, 08 Dec 2021 06:05:48 -0800 (PST)
MIME-Version: 1.0
References: <20211203192148.585399-1-martin.fernandez@eclypsium.com>
 <YaxWXACBguZxWmKS@kernel.org> <CAD2FfiG9wfeW_2xxZqBi9vsjzEJBRjJUZw+AQy1Taos4fh2TLA@mail.gmail.com>
 <Ya8MUOKPOKVfBfjJ@kernel.org>
In-Reply-To: <Ya8MUOKPOKVfBfjJ@kernel.org>
From:   Richard Hughes <hughsient@gmail.com>
Date:   Wed, 8 Dec 2021 14:05:36 +0000
Message-ID: <CAD2FfiEkn7dXPpCAaMdh5w8p3gXWzNABzd-nhwdTEd_AOZ7vnw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] x86: Show in sysfs if a memory node is able to do encryption
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        alex.bazhaniuk@eclypsium.com, alison.schofield@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 7 Dec 2021 at 07:25, Mike Rapoport <rppt@kernel.org> wrote:
> Can you please describe the actual check for the memory encryption and how
> it would impact the HSI rating?

The problem HSI is trying to solve is that customers are buying
systems where the CPU supports memory encryption, where the
motherboard and dram controller support memory encryption and where
the vendor says it's supported. But in some cases it's not working,
either because the system firmware is not working properly, or some
component requires updating to enable the feature. We're found quite a
few cases where people assumed this was all working fine, but on
looking closer, finding out that it's not working at all. The higher
HSI rating would only be available where most of the system RAM is
encrypted, although we've not worked out a heuristic number for "good
enough" yet.

> I wonder, for example, why did you choose per-node reporting rather than
> per-region as described in UEFI spec.

I think Dave is better to answer this question.

Richard.

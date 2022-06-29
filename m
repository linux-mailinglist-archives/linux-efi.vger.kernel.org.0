Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DAF560A13
	for <lists+linux-efi@lfdr.de>; Wed, 29 Jun 2022 21:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiF2TMy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Jun 2022 15:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiF2TMx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Jun 2022 15:12:53 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050D83336D;
        Wed, 29 Jun 2022 12:12:51 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id p136so23492949ybg.4;
        Wed, 29 Jun 2022 12:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cg4E+Wh5Xs3hBBKf1ibHf3ZyuhOE7sEJuSViPjSoZBY=;
        b=5X4n8KZVGGPnAwfWj/YIJ3Z4KFawbfoiHjwC0CVKkeZ4/SG2DhUWJVgEsqvSZO7QyC
         4BWAeTp8B1maBm2KC26lwf3k4O/c40m2D5rHacgVrzkloe1lpX64pkmJ7u9X/5TOZu9S
         4UH4stKIZSyxwhCZ58lIcTXXeXVrtteVBNA86Yw+kkP/UePPs2FqJ1QvVH7gsAaA6Bnq
         gNCf0V4LGIL3L/7Smirx+dNS1rqh/DeBmtImusJnwvTXeDHAeUdGCXDJOs0XfvTKF39R
         9KqdzLZS1FmW9agrw98GZ3jxoF20CwYYl0XzBytM0O71EPnc4GHeQDiecebMirfMEaKV
         ynEw==
X-Gm-Message-State: AJIora+h1W5t7Krp7/5N/JhYw+MWS+q5shQmkBHa6dpBS0HACNu3LKEz
        NN/CYu26HIJFJ+aIizmWQ//edFJ3rNeh2zWNIDXiNvP6
X-Google-Smtp-Source: AGRyM1sGcuDvB+XUTfQi2i05PaHWkOQ59uwaSEFN3O2cwM2V45sN4Ec0Na43K00o707AOJ9R41BrwxxNem2qyUYgeZU=
X-Received: by 2002:a25:9847:0:b0:669:b4c6:d081 with SMTP id
 k7-20020a259847000000b00669b4c6d081mr4868895ybo.633.1656529970285; Wed, 29
 Jun 2022 12:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220628125346.693304-1-sudeep.holla@arm.com> <20220629090635.6kf7thawc4qc4zi2@bogus>
 <20220629092137.a5fl33recfds7bq3@bogus>
In-Reply-To: <20220629092137.a5fl33recfds7bq3@bogus>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Jun 2022 21:12:39 +0200
Message-ID: <CAJZ5v0iuOMxmwbHr_2F4V6+VtNLR42BxkXDuty-EFhaeZwHvNg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] ACPI: Enable Platform Runtime Mechanism(PRM)
 support on ARM64
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jose Marinho <jose.marinho@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 29, 2022 at 11:22 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Jun 29, 2022 at 10:06:35AM +0100, Sudeep Holla wrote:
> > Hi Rafael,
> >
> > On Tue, Jun 28, 2022 at 01:53:42PM +0100, Sudeep Holla wrote:
> > > Hi,
> > >
> > > This tiny series is to enable Platform Runtime Mechanism(PRM) support on
> > > ARM64. Not much changes. Just enabling the build and moving the config
> > > option so that it is not listed under the topmost menu for ARM64.
> > >
> >
> > Ard has slightly modified version of patch 2/4 which updates few other
> > arch code. Since the PRMT driver build is dependent on that, is it OK
> > for you to ACK if you agree with other 3 patches(1,3,4) so that it can
> > be routed via efi tree. Alternatively, Ard has offered to provide a stable
> > branch if needed.
>
> Sorry pressed enter too early. I wanted to add reference to the commit in
> Ard's efi queue I was referring[1] and the email where we discussed how
> to deal with these PRMT patches[2]

The ACPI changes in this series are fine with me, so please feel free to add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to the patches and route them through the EFI tree.

Thanks!

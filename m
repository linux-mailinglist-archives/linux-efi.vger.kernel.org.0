Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF75561AE4
	for <lists+linux-efi@lfdr.de>; Thu, 30 Jun 2022 15:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbiF3NDP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Jun 2022 09:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbiF3NDO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Jun 2022 09:03:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 910BD6564;
        Thu, 30 Jun 2022 06:03:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E903F1063;
        Thu, 30 Jun 2022 06:03:12 -0700 (PDT)
Received: from bogus (unknown [10.57.39.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 392893F5A1;
        Thu, 30 Jun 2022 06:03:11 -0700 (PDT)
Date:   Thu, 30 Jun 2022 14:02:00 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jose Marinho <jose.marinho@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 0/4] ACPI: Enable Platform Runtime Mechanism(PRM)
 support on ARM64
Message-ID: <20220630130200.4jukcfwiescii32t@bogus>
References: <20220628125346.693304-1-sudeep.holla@arm.com>
 <20220629090635.6kf7thawc4qc4zi2@bogus>
 <20220629092137.a5fl33recfds7bq3@bogus>
 <CAJZ5v0iuOMxmwbHr_2F4V6+VtNLR42BxkXDuty-EFhaeZwHvNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iuOMxmwbHr_2F4V6+VtNLR42BxkXDuty-EFhaeZwHvNg@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 29, 2022 at 09:12:39PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 29, 2022 at 11:22 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Wed, Jun 29, 2022 at 10:06:35AM +0100, Sudeep Holla wrote:
> > > Hi Rafael,
> > >
> > > On Tue, Jun 28, 2022 at 01:53:42PM +0100, Sudeep Holla wrote:
> > > > Hi,
> > > >
> > > > This tiny series is to enable Platform Runtime Mechanism(PRM) support on
> > > > ARM64. Not much changes. Just enabling the build and moving the config
> > > > option so that it is not listed under the topmost menu for ARM64.
> > > >
> > >
> > > Ard has slightly modified version of patch 2/4 which updates few other
> > > arch code. Since the PRMT driver build is dependent on that, is it OK
> > > for you to ACK if you agree with other 3 patches(1,3,4) so that it can
> > > be routed via efi tree. Alternatively, Ard has offered to provide a stable
> > > branch if needed.
> >
> > Sorry pressed enter too early. I wanted to add reference to the commit in
> > Ard's efi queue I was referring[1] and the email where we discussed how
> > to deal with these PRMT patches[2]
> 
> The ACPI changes in this series are fine with me, so please feel free to add
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> to the patches and route them through the EFI tree.
> 

Thanks Rafael.

Hi Ard,

I assume you will pick up the patches(except 2/4 which is already in your
-next) with Rafael's ack.

-- 
Regards,
Sudeep

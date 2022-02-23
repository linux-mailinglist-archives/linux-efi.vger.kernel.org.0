Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3014C16D7
	for <lists+linux-efi@lfdr.de>; Wed, 23 Feb 2022 16:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241057AbiBWPd2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Feb 2022 10:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbiBWPd2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 23 Feb 2022 10:33:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43C6B10AE;
        Wed, 23 Feb 2022 07:33:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7ABE0B82032;
        Wed, 23 Feb 2022 15:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43445C340E7;
        Wed, 23 Feb 2022 15:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645630378;
        bh=/AAkU5gBwKJ11iiy6ANMfGVhONlOublBWimqlVHUZV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UyAVN/Wxw4biYhCzgzHLqJqcaPC4WzFFv8Jzk0TAgwwJ5z9aXotO2sDkXVzgY0dwD
         OKGD0AqnM3OmsJe+83YQPxFmADDEMBJpFv2y9r/eMyRQ/6dpeE2zWREbyVQz7sgzaL
         uev0/ZzHFo4IKW7/03tT/shASPhfPt9b3suj12PYSJ+NIHqNPS7b4AcJndr2mkvAqA
         pdCBGR2luJwOP0fAcDq5R9GPDdZ6j5ntyXfHkCUAmEqLpj4meHGwkKd14/6pkjCeGw
         HsM3xW2KmNrTIXwLamohKduyC56ys4UjueIdY7xrDtWMEJu1Jkxy9JO4lyXKe8d5QS
         bu+mRz2ZpL/uQ==
Date:   Wed, 23 Feb 2022 16:33:36 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Eric Snowberg <eric.snowberg@oracle.com>, dhowells@redhat.com,
        dwmw2@infradead.org, ardb@kernel.org, jmorris@namei.org,
        serge@hallyn.com, nayna@linux.ibm.com, keescook@chromium.org,
        torvalds@linux-foundation.org, weiyongjun1@huawei.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-security-module@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v10 0/8] Enroll kernel keys thru MOK
Message-ID: <YhZT0A7Zr6n6eCHK@iki.fi>
References: <20220126025834.255493-1-eric.snowberg@oracle.com>
 <YfFP6OHqBVNWKL2C@iki.fi>
 <YfFTf6vIpNMIrwH0@iki.fi>
 <78d2c13ad60b5f845cb841d257d1b41290f575c6.camel@linux.ibm.com>
 <YhKP12KEmyqyS8rj@iki.fi>
 <8e9e4bc3bbd831a606f264ec3f4dfcafdeebece6.camel@linux.ibm.com>
 <YhTWhcIx9B/pyiwD@iki.fi>
 <5f685d7d4aa6f4253cb4b779d639bd8435dedacc.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f685d7d4aa6f4253cb4b779d639bd8435dedacc.camel@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Feb 22, 2022 at 08:43:18AM -0500, Mimi Zohar wrote:
> On Tue, 2022-02-22 at 13:26 +0100, Jarkko Sakkinen wrote:
> > This is the problem I'm encountering:
> > 
> > https://lore.kernel.org/keyrings/YhLNYxBTbKW62vtC@iki.fi/
> 
> Try using the Message-Id: <
> 20220126025834.255493-1-eric.snowberg@oracle.com>
> 
> -- 
> thanks,
> 
> Mimi

OK, now the patch set is fully applied. Thank you Mimi, and Eric, apologies
for the confusion.

BR, Jarkko

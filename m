Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02EB584368
	for <lists+linux-efi@lfdr.de>; Thu, 28 Jul 2022 17:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbiG1Pn0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Jul 2022 11:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbiG1PnV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Jul 2022 11:43:21 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3AE6A49C
        for <linux-efi@vger.kernel.org>; Thu, 28 Jul 2022 08:43:21 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8E2F921F;
        Thu, 28 Jul 2022 15:43:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8E2F921F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1659023000; bh=1neTIY3xm1jMdQv4l8CARyFeD/JU7RMIRvBQJkl+k4U=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Oc+ipWN+ZMIMDIN+9A3Sd+rKhJFA4etg9GIP3wlVmgO4ayqQGlOUwoTJ/UqgrJKWy
         NEw6jTeIS28IiB47d3J3DmDLZkGv/86T8RFgbbQkSRPt37xGtz7U0V8GKTW1ZtsiTh
         SzpG9LNQSEziGS1WmFZN9LXSIomDUYFykqu5WRawgKjw7yUtoWmRGK/cnU9UCYIW8t
         wc9gwcUUfLaVjfqvU4gd/tl17OTDZuD2XPOM8CM5GQKpVVE83AbyR9Hs1GmucT97WL
         fGQscttJviUTPHr2CccrkW8c5qzfgmsJm/gh656IbRG5k6tEOe88efLIntEgJaPM+I
         w+XOLIXdzaH4A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Ard Biesheuvel <ardb@kernel.org>,
        =?utf-8?Q?Jo=C3=A3o?= Paulo Rechi Vita <jprvita@gmail.com>
Cc:     linux@endlessos.org,
        =?utf-8?Q?Jo=C3=A3o?= Paulo Rechi Vita 
        <jprvita@endlessos.org>, linux-efi <linux-efi@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] docs: efi-stub: Fix paths for x86 / arm stubs
In-Reply-To: <CAMj1kXH4fOqdj4EN8r+=SvRLcn_ky1hKWqHzOG5csAc8P5QVog@mail.gmail.com>
References: <20220727140539.10021-1-jprvita@endlessos.org>
 <CAMj1kXH4fOqdj4EN8r+=SvRLcn_ky1hKWqHzOG5csAc8P5QVog@mail.gmail.com>
Date:   Thu, 28 Jul 2022 09:43:20 -0600
Message-ID: <87lesdb5uv.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Ard Biesheuvel <ardb@kernel.org> writes:

> On Wed, 27 Jul 2022 at 07:06, Jo=C3=A3o Paulo Rechi Vita <jprvita@gmail.c=
om> wrote:
>>
>> This fixes the paths of x86 / arm efi-stub source files.
>>
>> Signed-off-by: Jo=C3=A3o Paulo Rechi Vita <jprvita@endlessos.org>
>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

Applied, thanks.

jon

Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905FE605EDA
	for <lists+linux-efi@lfdr.de>; Thu, 20 Oct 2022 13:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiJTL3d (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Oct 2022 07:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiJTL3a (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Oct 2022 07:29:30 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E00B2714;
        Thu, 20 Oct 2022 04:29:26 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 5C4CB419E9C7;
        Thu, 20 Oct 2022 11:29:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 5C4CB419E9C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1666265364;
        bh=Bktf/BxjJqjDJ23NM9HZvwVXwoTJKkV8c5PmHQJNsTY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jssNHKHKmIPg/5ykG2ksrA/aBKD6W1fr5In8ptWGD0v/LTFWyaIa2RXqVB2jDBQN8
         iqh7J/piT0z7cwInKpkO+v4lIbljodXVOsm4Og5PnyJUCLJ9REuWd2XSB6rUemXiMw
         vPjwoMz8Sj9gLDv8xMktsilczEP31Hje+5Xp7Ckk=
MIME-Version: 1.0
Date:   Thu, 20 Oct 2022 14:29:24 +0300
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 04/16] x86/boot: Increase boot page table size
In-Reply-To: <CAMj1kXG6wZ2UK7cPeym8M4WioCUABa5qAo48LyGKHNA=QZ8YCw@mail.gmail.com>
References: <cover.1662459668.git.baskov@ispras.ru>
 <e4dd6f83a49551d72682ad399dba8feeea955fb4.1662459668.git.baskov@ispras.ru>
 <CAMj1kXG6wZ2UK7cPeym8M4WioCUABa5qAo48LyGKHNA=QZ8YCw@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <a9b80446b5898d5ecc370e9429eed351@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2022-10-19 10:08, Ard Biesheuvel wrote:
> On Tue, 6 Sept 2022 at 12:41, Evgeniy Baskov <baskov@ispras.ru> wrote:
>> 
>> Previous calculations ignored pages implicitly mapped by ACPI code,
> 
> I'm not sure I understand what this means. Which ACPI code and which
> pages does it map?

Code from boot/compressed/{acpi.c,efi.c} that touches ACPI/EFI tables
is currently mapping pages that contain the tables implicitly by
causing page faults. And those mappings may require additional
memory for page tables. It became more apparent when I were removing
memory mapping from page fault handler.

> 
>> so theoretical upper limit is higher than was set.
...

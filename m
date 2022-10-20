Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B8E605FDD
	for <lists+linux-efi@lfdr.de>; Thu, 20 Oct 2022 14:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiJTMOc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Oct 2022 08:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiJTMOb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Oct 2022 08:14:31 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8273062E7;
        Thu, 20 Oct 2022 05:14:27 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 3151B419E9CE;
        Thu, 20 Oct 2022 12:14:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 3151B419E9CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1666268066;
        bh=TKnOmkXuyK8JsLKTQAiNY3IGD3QnoNaMckFWD/89NU8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YeJipgozyrYQKq8Zw5lBALkGRRoqxEzDNqp5d74dYWZcs6eO5a9OsJKCzTXdGNeWs
         /UjCXdhelieKvn6dqLtkyr/1YPh2zMhy7EZ9uMpNojLVrmla6534FYmU1sfmMxGwyi
         Kq0sAPhYWIWucrCnhV7CuDJEXa4TpbPpR3IYorGc=
MIME-Version: 1.0
Date:   Thu, 20 Oct 2022 15:14:26 +0300
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
Subject: Re: [PATCH 12/16] x86/boot: Add EFI kernel extraction interface
In-Reply-To: <CAMj1kXFNhayBgXSaHxKpdnWbmQsoG5WpT9U6FhOXqJ0dsHHp4w@mail.gmail.com>
References: <cover.1662459668.git.baskov@ispras.ru>
 <8e9f2d7b0645e17efaa9eec0423f6d2c4a55fc16.1662459668.git.baskov@ispras.ru>
 <CAMj1kXFNhayBgXSaHxKpdnWbmQsoG5WpT9U6FhOXqJ0dsHHp4w@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <52b055eb43ea44df05a6fe02714993e6@ispras.ru>
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

On 2022-10-19 10:27, Ard Biesheuvel wrote:
> On Tue, 6 Sept 2022 at 12:42, Evgeniy Baskov <baskov@ispras.ru> wrote:
...
>> 
>> +void init_efi_console(struct efi_iofunc *iofunc)
> 
> struct efi_iofunc does not exist yet
> 

My bad, will move the definition from the next patch to this one.
Thanks for pointing out.

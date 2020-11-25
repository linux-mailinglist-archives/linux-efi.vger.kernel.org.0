Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58FA52C3D4C
	for <lists+linux-efi@lfdr.de>; Wed, 25 Nov 2020 11:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgKYKKX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Nov 2020 05:10:23 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:57084 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgKYKKX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 Nov 2020 05:10:23 -0500
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id A42818AB5FC;
        Wed, 25 Nov 2020 11:10:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1606299018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vr7kbkvJWj+ymD60j5y+9DhJLqtnSyDODxQOSh6KZPE=;
        b=GIAYy4xnW4qw/YSkY+woRcIVDkFspmWJp8MMujKEsDBDwB/y1rBVoGSxwe3DhGUeXkdRYP
        VX3XBGmsQRBeQdjaZwvVGltpwcoQJhM4XALo8sk1XNWMpW8hXLbuBxekT7q5Ew64WEupOC
        bL5Re7o9eDhY46FRTo+07r27oraitfY=
MIME-Version: 1.0
Date:   Wed, 25 Nov 2020 11:10:18 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        matthew.garrett@nebula.com, jk@ozlabs.org
Subject: Re: Oops (probably) unmounting /oldroot/firmware/efi/efivars.
In-Reply-To: <X74WuTEjLXzAziwJ@kroah.com>
References: <5f31cde519b941308412b3849197ee7c@AcuMS.aculab.com>
 <CAMj1kXHhetomAx4Kd5McnvZQev9j1d-C1Og7h+J7V009WTiwxA@mail.gmail.com>
 <c4c57a4b65d57bb7b2e87870a92558a5@natalenko.name>
 <X74WuTEjLXzAziwJ@kroah.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <31d944b52416dd3fb82902566bc3b23b@natalenko.name>
X-Sender: oleksandr@natalenko.name
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello.

On 25.11.2020 09:32, Greg Kroah-Hartman wrote:
> On Tue, Nov 24, 2020 at 10:24:27PM +0100, Oleksandr Natalenko wrote:
>> Hi.
>> 
>> On 24.11.2020 15:23, Ard Biesheuvel wrote:
>> > Surely caused by
>> >
>> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/efivarfs?id=fe5186cf12e30facfe261e9be6c7904a170bd822
>> 
>> This also soaked through the stable queue into v5.9.11, and now the 
>> same BUG
>> is triggered in the latest stable kernel.
>> 
>> /cc Greg
> 
>  cc: me for what?
> 
> /me has no context as to what to do here...

This was a precursor to 
https://lore.kernel.org/stable/X74VBej49SCPVisA@kroah.com/ and you 
already jumped in there.

Thanks.

-- 
   Oleksandr Natalenko (post-factum)

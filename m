Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C48E17B87B
	for <lists+linux-efi@lfdr.de>; Fri,  6 Mar 2020 09:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgCFInP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 6 Mar 2020 03:43:15 -0500
Received: from mail.inango-systems.com ([178.238.230.57]:48846 "EHLO
        mail.inango-sw.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgCFInP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 6 Mar 2020 03:43:15 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.inango-sw.com (Postfix) with ESMTP id DCD5910808D1;
        Fri,  6 Mar 2020 10:43:12 +0200 (IST)
Received: from mail.inango-sw.com ([127.0.0.1])
        by localhost (mail.inango-sw.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id uqHrDe7cnF2u; Fri,  6 Mar 2020 10:43:12 +0200 (IST)
Received: from localhost (localhost [127.0.0.1])
        by mail.inango-sw.com (Postfix) with ESMTP id 2721310808D7;
        Fri,  6 Mar 2020 10:43:12 +0200 (IST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.inango-sw.com 2721310808D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inango-systems.com;
        s=45A440E0-D841-11E8-B985-5FCC721607E0; t=1583484192;
        bh=YxTbu9kQnvjv5MbGULCxcOml7fOIMlApQuM/jcMVt1s=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=anA5w44sgin0xHU3Gy1VamxJC+hql6/9VLZkgk8OpALSgA3OPd4U4HqaBzpTs6G8v
         dp42ByDlpayqdpEy8HU5eFclbZWAWIJPu2AMm9M6nL1NiQlRSxuQ0VPBLSv2tKEHse
         hVowh+2MNBhr5vjddFleqdjemexqA1/KYpl9rauOrDAJQYqg2hnx2wWyP/N4qwjIqx
         wciEU79HVPMn1TIa+syHCcKrxDU+I9ZFPJp50NSh8oWeXdKPKLi7ZImYAUklCi4B1b
         tTu571FKpMy7jwzSWjBiIbE+i+lEOooEVyMqLvwKBcpzFUW5uBbsPDrpYqqr2VuR2E
         eI+YNRfcV7fjA==
X-Virus-Scanned: amavisd-new at inango-sw.com
Received: from mail.inango-sw.com ([127.0.0.1])
        by localhost (mail.inango-sw.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NTHAflgbJcax; Fri,  6 Mar 2020 10:43:12 +0200 (IST)
Received: from mail.inango-sw.com (mail.inango-sw.com [172.17.220.3])
        by mail.inango-sw.com (Postfix) with ESMTP id 04C0E10807C8;
        Fri,  6 Mar 2020 10:43:12 +0200 (IST)
Date:   Fri, 6 Mar 2020 10:43:11 +0200 (IST)
From:   Nikolai Merinov <n.merinov@inango-systems.com>
To:     hch <hch@infradead.org>
Cc:     Davidlohr Bueso <dave@stgolabs.net>, Jens Axboe <axboe@kernel.dk>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <711479725.2305.1583484191776.JavaMail.zimbra@inango-systems.com>
In-Reply-To: <20200224170813.GA27403@infradead.org>
References: <20181124162123.21300-1-n.merinov@inango-systems.com> <20191224092119.4581-1-n.merinov@inango-systems.com> <20200108133926.GC4455@infradead.org> <26f7bd89f212f68b03a4b207e96d8702c9049015.1578910723.git.n.merinov@inango-systems.com> <20200218185336.GA14242@infradead.org> <797777312.1324734.1582544319435.JavaMail.zimbra@inango-systems.com> <20200224170813.GA27403@infradead.org>
Subject: Re: [PATCH v3] partitions/efi: Fix partition name parsing in GUID
 partition entry
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.17.220.3]
X-Mailer: Zimbra 8.8.15_GA_3888 (ZimbraWebClient - GC80 (Linux)/8.8.15_GA_3890)
Thread-Topic: partitions/efi: Fix partition name parsing in GUID partition entry
Thread-Index: YUv+o3doV5Qr5r5T5kLUarb2avqorw==
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Christoph,

Should I perform any other steps in order to get this change in the master?

Regards,
Nikolai

----- Original Message -----
> From: "hch" <hch@infradead.org>
> To: "n merinov" <n.merinov@inango-systems.com>
> Cc: "hch" <hch@infradead.org>, "Davidlohr Bueso" <dave@stgolabs.net>, "Jens Axboe" <axboe@kernel.dk>, "Ard Biesheuvel"
> <ardb@kernel.org>, "linux-efi" <linux-efi@vger.kernel.org>, "linux-block" <linux-block@vger.kernel.org>, "linux-kernel"
> <linux-kernel@vger.kernel.org>
> Sent: Monday, February 24, 2020 10:08:13 PM
> Subject: Re: [PATCH v3] partitions/efi: Fix partition name parsing in GUID partition entry

> On Mon, Feb 24, 2020 at 01:38:39PM +0200, Nikolai Merinov wrote:
>> Hi Christoph,
>> 
>> > I'd rather use plain __le16 and le16_to_cpu here. Also the be
>> > variants seems to be entirely unused.
>> 
>> Looks like I misunderstood your comment from
>> https://patchwork.kernel.org/patch/11309223/:
>> 
>> > Please add a an efi_char_from_cpu or similarly named helper
>> > to encapsulate this logic.
>> 
>> The "le16_to_cpu(ptes[i].partition_name[label_count])" call is the
>> full implementation of the "efi_char_from_cpu" logic. Do you want
>> to encapsulate "utf16_le_to_7bit_string" logic entirely like in
>> the attached version?
> 
> I think I though of just the inner loop, but your new version looks even
> better, so:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

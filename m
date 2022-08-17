Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D25459733E
	for <lists+linux-efi@lfdr.de>; Wed, 17 Aug 2022 17:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237876AbiHQPim convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-efi@lfdr.de>); Wed, 17 Aug 2022 11:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240066AbiHQPij (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 Aug 2022 11:38:39 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC27D14090
        for <linux-efi@vger.kernel.org>; Wed, 17 Aug 2022 08:38:36 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-42-tBvHS8GtOguVcAWJge1fiA-1; Wed, 17 Aug 2022 16:38:34 +0100
X-MC-Unique: tBvHS8GtOguVcAWJge1fiA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.38; Wed, 17 Aug 2022 16:38:33 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.040; Wed, 17 Aug 2022 16:38:33 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jia He' <justin.he@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "toshi.kani@hpe.com" <toshi.kani@hpe.com>,
        "nd@arm.com" <nd@arm.com>, kernel test robot <lkp@intel.com>
Subject: RE: [PATCH v2 6/7] apei/ghes: Use unrcu_pointer for cmpxchg
Thread-Topic: [PATCH v2 6/7] apei/ghes: Use unrcu_pointer for cmpxchg
Thread-Index: AQHYskbHFo9dfaPEtU2VF7GmkxsV462zOhBg
Date:   Wed, 17 Aug 2022 15:38:33 +0000
Message-ID: <6ca673e869c44b4690b5b6653c28ae11@AcuMS.aculab.com>
References: <20220817143458.335938-1-justin.he@arm.com>
 <20220817143458.335938-7-justin.he@arm.com>
In-Reply-To: <20220817143458.335938-7-justin.he@arm.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Jia He
> Sent: 17 August 2022 15:35
> 
> ghes_estatus_caches should be add rcu annotation to avoid sparse warnings.
>    drivers/acpi/apei/ghes.c:733:25: sparse: sparse: incompatible types in comparison expression
> (different address spaces):
>    drivers/acpi/apei/ghes.c:733:25: sparse:    struct ghes_estatus_cache [noderef] __rcu *
>    drivers/acpi/apei/ghes.c:733:25: sparse:    struct ghes_estatus_cache *
>    drivers/acpi/apei/ghes.c:813:25: sparse: sparse: incompatible types in comparison expression
> (different address spaces):
>    drivers/acpi/apei/ghes.c:813:25: sparse:    struct ghes_estatus_cache [noderef] __rcu *
>    drivers/acpi/apei/ghes.c:813:25: sparse:    struct ghes_estatus_cache *
> 
> unrcu_pointer is to strip the __rcu in cmpxchg.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
>  drivers/acpi/apei/ghes.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 9272d963b57d..92ae58f4f7bb 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -144,7 +144,7 @@ struct ghes_vendor_record_entry {
>  static struct gen_pool *ghes_estatus_pool;
>  static unsigned long ghes_estatus_pool_size_request;
> 
> -static struct ghes_estatus_cache *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
> +static struct ghes_estatus_cache __rcu *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
>  static atomic_t ghes_estatus_cache_alloced;
> 
>  static int ghes_panic_timeout __read_mostly = 30;
> @@ -834,8 +834,9 @@ static void ghes_estatus_cache_add(
>  	}
>  	/* new_cache must be put into array after its contents are written */
>  	smp_wmb();
> -	if (slot != -1 && cmpxchg(ghes_estatus_caches + slot,
> -				  slot_cache, new_cache) == slot_cache) {
> +	if (slot != -1 && unrcu_pointer(cmpxchg(ghes_estatus_caches + slot,
> +				RCU_INITIALIZER(slot_cache),
> +				RCU_INITIALIZER(new_cache)))) {

Did you test this?
There seems to be an == missing.

	David

>  		if (slot_cache)
>  			call_rcu(&slot_cache->rcu, ghes_estatus_cache_rcu_free);
>  	} else
> --
> 2.25.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


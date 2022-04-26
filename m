Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9C850FE31
	for <lists+linux-efi@lfdr.de>; Tue, 26 Apr 2022 15:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiDZNEv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 Apr 2022 09:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350401AbiDZNEt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 26 Apr 2022 09:04:49 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBBA24F1F
        for <linux-efi@vger.kernel.org>; Tue, 26 Apr 2022 06:01:41 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2ef5380669cso181063537b3.9
        for <linux-efi@vger.kernel.org>; Tue, 26 Apr 2022 06:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7U8qS0+N2U3Q5otz/HZN1++iKg/iT5uNuTdkb8n5jkc=;
        b=TLmJGydE2KBBsr5CCQaiOtLAlF5muH8VV+zjfD59n+L3Zv3Ojm/dSA9BvQGTNdMcNG
         +gE/78zsC4oozu52jkqdgMV/Y7eYREFBsJJ20IePiWRPpyDC4kgZzmV6HyTMxy8BswWi
         /wrYmzfpOlFHP6zCETpaxqlzaxHJiD0EuE4A6KV/f92muFwO1zBe+INc8wwEx+t524jW
         5ayOtvzCGgFL6lJQSFwhXoA82F2J3acL9RA55Ip5z6GtqmIeQy9G1MoX5r2LoCwoz/BY
         RgA2FUrQNa4A6Beq6LfORF/DSSGmcDhynZsjDFZUvGXArsKWWfRV3OcBIDpIISmzHlWh
         dCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7U8qS0+N2U3Q5otz/HZN1++iKg/iT5uNuTdkb8n5jkc=;
        b=xnEVQ85Sik3rOws8csnWa2AIJMOwsjnb0P7cadZapTP7JjEQuXj+ktQi0y7yzIkg0R
         Zf/CrgKOToXfk4u4bgNZ+0yu4PliIloMeKx4S1AJpnGByHLRvXaI0JHZbEt02azWdXIv
         mzvdWDQZzqKrkHThngAqv3D+Nb2O6h74ck9Vct5ojhTJq6EuJUfpm91M01lmFm1myZkn
         uTkLS/nvobkCeXmfLrfuySQxbUX9f0vJISMqFNCQsjm9iKAJ27PmXaSzWGpyN02k5mWK
         oP1W8CBq79powL8u0OvFmPZ46gzyyH+WCBPmtqirK6/LnbDWkKBIVm7g7zxmHK4wivpa
         tvMw==
X-Gm-Message-State: AOAM532VPNeOJK0E2B3b8yejcPr1tu1SddwD5NnKNfirANqmZoR1cIIA
        GO3anooVS7ohfBxoRl7Aal2SbZ39GezOi4D766Fxbg==
X-Google-Smtp-Source: ABdhPJxrixuEuLJzGGb3wWOmo8aOeK7hJWm6Gw2wZBOhgN5jn0XSBRugRdDxqxN2+b86OfWWA5UEk9IAFBtEcwScaH4=
X-Received: by 2002:a0d:d953:0:b0:2f7:d5ce:f204 with SMTP id
 b80-20020a0dd953000000b002f7d5cef204mr12146537ywe.502.1650978100274; Tue, 26
 Apr 2022 06:01:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:10a:0:0:0:0:0 with HTTP; Tue, 26 Apr 2022 06:01:39 -0700 (PDT)
In-Reply-To: <YmeOIrINQAN1aZhu@kernel.org>
References: <20220425171526.44925-1-martin.fernandez@eclypsium.com>
 <20220425171526.44925-9-martin.fernandez@eclypsium.com> <YmeOIrINQAN1aZhu@kernel.org>
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
Date:   Tue, 26 Apr 2022 10:01:39 -0300
Message-ID: <CAKgze5YC_7tmrJpePH_58gbNADCQYF1S-p4Fcwp_hDy7edGGiQ@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] drivers/node: Show in sysfs node's crypto capabilities
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 4/26/22, Mike Rapoport <rppt@kernel.org> wrote:
> On Mon, Apr 25, 2022 at 02:15:26PM -0300, Martin Fernandez wrote:
>> Show in each node in sysfs if its memory is able to do be encrypted by
>> the CPU, ie. if all its memory is marked with EFI_MEMORY_CPU_CRYPTO in
>> the EFI memory map.
>>
>> Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
>> ---
>>  Documentation/ABI/testing/sysfs-devices-node | 10 ++++++++++
>>  drivers/base/node.c                          | 10 ++++++++++
>>  2 files changed, 20 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/sysfs-devices-node
>>
>> diff --git a/Documentation/ABI/testing/sysfs-devices-node
>> b/Documentation/ABI/testing/sysfs-devices-node
>> new file mode 100644
>> index 000000000000..5fd5dc7fc2eb
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-devices-node
>> @@ -0,0 +1,10 @@
>> +What:		/sys/devices/system/node/nodeX/crypto_capable
>> +Date:		April 2022
>> +Contact:	Martin Fernandez <martin.fernandez@eclypsium.com>
>> +Users:		fwupd (https://fwupd.org)
>> +Description:
>> +		This value is 1 if all system memory in this node is
>> +		marked with EFI_MEMORY_CPU_CRYPTO, indicating that the
>> +		system memory is capable of being protected with the
>> +		CPU=E2=80=99s memory cryptographic capabilities. It is 0
>> +		otherwise.
>
> I understand that currently this feature is only for x86, but if non-EFI
> architectures will start using MEMBLOCK_CRYPTO_CAPABLE, the sysfs attribu=
te
> for will be relevant form them as well.
>
> How about
> 	This value is 1 if all system memory in this node is capable of
> 	being protected with the CPU's memory cryptographic capabilities.
> 	It is 0 otherwise.
> 	On EFI systems the node will be marked with EFI_MEMORY_CPU_CRYPTO.
>

Good point. I'll change it.

>> \ No newline at end of file
>> diff --git a/drivers/base/node.c b/drivers/base/node.c
>> index ec8bb24a5a22..1df15ea03c27 100644
>> --- a/drivers/base/node.c
>> +++ b/drivers/base/node.c
>> @@ -560,11 +560,21 @@ static ssize_t node_read_distance(struct device
>> *dev,
>>  }
>>  static DEVICE_ATTR(distance, 0444, node_read_distance, NULL);
>>
>> +static ssize_t crypto_capable_show(struct device *dev,
>> +				   struct device_attribute *attr, char *buf)
>> +{
>> +	struct pglist_data *pgdat =3D NODE_DATA(dev->id);
>> +
>> +	return sysfs_emit(buf, "%d\n", pgdat->crypto_capable);
>> +}
>> +static DEVICE_ATTR_RO(crypto_capable);
>> +
>>  static struct attribute *node_dev_attrs[] =3D {
>>  	&dev_attr_meminfo.attr,
>>  	&dev_attr_numastat.attr,
>>  	&dev_attr_distance.attr,
>>  	&dev_attr_vmstat.attr,
>> +	&dev_attr_crypto_capable.attr,
>>  	NULL
>>  };
>>
>> --
>> 2.30.2
>>
>
> --
> Sincerely yours,
> Mike.
>

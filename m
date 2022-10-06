Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A1C5F6382
	for <lists+linux-efi@lfdr.de>; Thu,  6 Oct 2022 11:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbiJFJWI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Oct 2022 05:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiJFJWH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Oct 2022 05:22:07 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10077.outbound.protection.outlook.com [40.107.1.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7179F24089;
        Thu,  6 Oct 2022 02:22:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCKNTWx7A7Pk/PnJNvTbQj6zeHlWJXcxO+jzO4eisAual3gLFa4B5cA257xG4NqZP9g0lVy5UDfBnqWOQG+xG5rPKAsuxcZkiGZQ5wpbWhWAaYpaFxsok0Z0PFfctZnzphmyya1LkWbU5GEt8CpBItCLZt6ivhi/XOG11O/CrYk/1PB3g5yqJ84cTz2jNzU7Xmf32/ey1Af9fUNY0ydNj3ToYPhk5PmOKwbmzNA/eajru5J5h2iplz6OC0j8YEI/u8wLd7DVwIjfXl3fZr8PLbaPcN7y1Omk7eF66b3WK0YDSfRCCbmUgyy2kmdAtkWdXHZ9fs2TSNSkg08NnpqaOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OZkKAHORdzT1HwfMcAmHm7TE/vpkKv9U2RN4iYwsD8=;
 b=ZNzcHalwIWnKcl55n4lzK+n4OfcCPUacCDgcXoTMIZlTJAzxbZZ7EINHSgI/e6/4LU2DMV0asnM0iGnp7bn/97Vy+tAU0fjhkjXDJPEtnREQSY7GtB7QuTAsw5+CSC3ItNxZAlcJll99b50xQW1oh26V3Uyp/J0ZMOE8zE8teROAagaOSOgGDppYWH4kyUeG6l4X/f0epLoHvke99mw9MGSY3QcXzY45P1PgHth5pbi0flGqmJ2+e7FyHNlXnJJ0ZpKP+Jluh9v0arJYE0ej7Vr1ujdfMN68WlZRBfAgacbcRpg8n4ZI+DSx7fn9gmDxYvucl37Y7ClEkOJHWPlbrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OZkKAHORdzT1HwfMcAmHm7TE/vpkKv9U2RN4iYwsD8=;
 b=2JPybmyPuaR/MzhOA0fqc7FGtBu43zazD1RBVrGLiQPvXPUnYVN4HQKGBgUJoZPjUtt1MDzlgsL9dM8a1nijUiSV1imsAjMbP/jmcXqlz1InIy21S5UoA2isD35sMjBRcLSuw1/3nVUIgDGLZACjGx4knF+ANiWlECq9bW1q/7QotkzPXat1fj4jRpTLozBd1fKoUo5frJZTsy4MEfOT9TJrTGjVucMvvL8w4/JBTnIFnuP25bYNyOcmNvs3MlIwOpmH3b0IddDC/tpBwfCBK2slKKhEqe2ykC9Mrk4ZYB64G9F+Mfwlsamf/CdfHmXFDbYNYGZU59zKj7yJxezr6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by AM7PR04MB7143.eurprd04.prod.outlook.com (2603:10a6:20b:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Thu, 6 Oct
 2022 09:22:03 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::2459:15ae:e6cb:218a]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::2459:15ae:e6cb:218a%7]) with mapi id 15.20.5676.034; Thu, 6 Oct 2022
 09:22:03 +0000
Message-ID: <ba28a45c-166e-7b9a-3af9-40d249d7cf0e@suse.com>
Date:   Thu, 6 Oct 2022 11:22:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 1/2] Avoid using EFI tables Xen may have clobbered
Content-Language: en-US
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>, Ard Biesheuvel <ardb@kernel.org>
References: <cover.1664298147.git.demi@invisiblethingslab.com>
 <f3b624e99adfdbbfc1976a60a73a6b5950e1840d.1664298147.git.demi@invisiblethingslab.com>
 <282a225d-8782-0321-6f0e-19dd4510dc42@suse.com>
 <CAMj1kXFQNqsW5RfHGac-eGbosJHBybu6+-Fap_bi_kVxWNpGeg@mail.gmail.com>
 <YzcjeiOW8+i2Zxsd@itl-email>
 <CAMj1kXHBBbCNV3CLesqZi7ttmmi8y4tZ1KO5vievy_CJrU2o3Q@mail.gmail.com>
 <YzeaKjmls1YI/3ox@itl-email> <01d22092-8292-8ed7-ece7-9ca32d15bbce@suse.com>
 <YzxxXuovwQt3NskE@itl-email> <a0dc1158-01b1-4272-b86e-52f4996f0747@suse.com>
 <Yz3I2qwl243h9ZfZ@itl-email>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <Yz3I2qwl243h9ZfZ@itl-email>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::18) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6560:EE_|AM7PR04MB7143:EE_
X-MS-Office365-Filtering-Correlation-Id: e0ba2ea8-3ae7-49c5-b379-08daa77c3af2
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gjYiv1uPP8KiNLv3qJ/fFlyCpRYPagm+iGa4e/cRpDuQS+yQ22lWOw5lOEk64FDbiImtY6gh/EhCSxS11rO1ywc459Ub+C3NSf5qeblLJin+VCI3SGDvjqw/cPXwxfmLjJrwtnRnTjpVgMwp1et9ygWxBUOpUrPglI9JSqL/c6sJ/d1SElyMPzEY1y3a3jikgWHC+pEqduXJDTRjqbaK+V2J+1f4JMHT/vp654ZmdqFziUDxOTvZnS6kByc+Ee7wUMHghvZD+21GXy1IzqzHDtsre46dIRgpY4xCSDAbgacY3J+6s1LqtO4TK9zZLbk+itpLCxfqMJgcCRytuSauXs55+3YpnMgdaj3waTR5LH8I5QxbuYCsaXvJCtvO1wzeQCM8UOJaszSRs3x1OLbfYwVqQk7tNoQs1yKfLpRiO0P0HHSPPpc65IR3ZRj8omQDSAHmx+AqA6rmJ42UL12Rd03J3aHEqbfJKAB8vCL2azsTmwtPDHyxLz4hoxL4w6T6TYRmEmBd7hSNXcrrMWL0WZyhVweIsKvEy8aNwA/zL+EYkWywppqOwXKIXqJKE5t+k/vFQgSgKFpLWggLPCe8DBFNGr2yifxzB5HQaqdqTeQhayxgm3388QBbNragWckdHsng6K7/4YN23uqxM1KKhTuothzcnWiYm+5GO/ZmzPGISeT8zI3LnHFGt+u4C29XgFB8iwavPh7aZpw38LIP9mhhZdjkLyh5m/RM4FbI7ehwVCLwG7I3ibkbDjNgHzPNtxr8fiiil5rDp0gZvyjLc9Kh3mLWy7Sdj7V+x6VNSF8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(39850400004)(136003)(396003)(376002)(451199015)(7416002)(6512007)(8936002)(26005)(36756003)(5660300002)(316002)(6506007)(53546011)(186003)(41300700001)(2616005)(83380400001)(2906002)(8676002)(66556008)(66946007)(4326008)(66476007)(31686004)(478600001)(38100700002)(6916009)(86362001)(31696002)(54906003)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWNMSjZxVVVZaktMKzlBU3JGa1lLaE8vTkpHcDBReUlFeExmYkhueXV2UEc5?=
 =?utf-8?B?TktDRE9tdE5YNkZpUVYvZlFma2RmZ29vRWlESldMdzRIZ1JLV2V3ZXQrbmRX?=
 =?utf-8?B?UjAxWGpoekhQcmNhWVh1UWRNUXFPOVk0MDNmZWRKejZpZjJzK1lWNzV3TStM?=
 =?utf-8?B?Qlg2NWdxaVVaTlcyZ1g1TFhJNjlQYU1ITFdOMjJLT1hSQ2E4NWRkUjMyOHor?=
 =?utf-8?B?eUVnSVFCbzZWajdVaFNBQ3JiMWV2VUV3bUVEb2wvSnJRUlN1S2FObnpZRTMy?=
 =?utf-8?B?Nm1FRkZQMkxsLzNIWWZJWU9OOGRLQ3RIMkdvQkljYTc1bm1SOURlM2EzRWpR?=
 =?utf-8?B?NGhlQVJwOUR4S04wVDJ0dkloTGRoWWdWWFp0UXAveXZ0Wk5BbkQxL20zOFV5?=
 =?utf-8?B?dWZqMFBJS1ROd3VrcmpidGpOeHdmU2d6cGFuNGY3TVRSTk1rcTBEQno3MGsx?=
 =?utf-8?B?Mzd0WVovcWRnUVo0RXNsNnBLS0ZkcTNjZUVWdDk5bTl6ZkN4aG5GMXROUHBy?=
 =?utf-8?B?SkZEbXFybHJRbkR6ZStvNWNrSyt3dkNQREZwckxndElDdVdTOEh3OXowbzNa?=
 =?utf-8?B?SWRGRUQ3NmtZZWdEZnNOQzY4RXFOVXpHWDFiZHpKZ09JNjZ4YVJsOW5nWERm?=
 =?utf-8?B?WkxwaGtmYjFkL1krWkdvcTk2VkMyS1g4VFkyWVZkakI2dVhyVXV5cng1YnBz?=
 =?utf-8?B?TmJRV2pEUjdmM3hZTjR0KzBydk9xbmNZQzRTYjB2MnZvYllWQTFib0RmQkg5?=
 =?utf-8?B?a1F0eU56ellWcHlRVDFQdWlUMmY3bWd2c094TjdBbFhXYWdoeHpKR1hEUXZM?=
 =?utf-8?B?T1hLcGlvWUNSblhOeWM5VHRlbHowYUxyM0NBN29nVDlneEp4UGlmM0NDeTFp?=
 =?utf-8?B?TVR2TWhrZ3pQK3N1TnlCT3BZTkFLQ04xSEQ5REo0MGJDZVdWVXpzRms4YUJl?=
 =?utf-8?B?RlRqdGYzclo4azhtSUVkSTZXa1E2TjVFelJoQURkeVFxaVhJYkdONEtwUFR6?=
 =?utf-8?B?UE91cytNNHl4b0NkaUhxMHhhZUpyRldtRnJkOEtLdHQyT1JNUHRudFhOVUJi?=
 =?utf-8?B?OS9iVGpJSW5LWkN3NFZzTjA2WmJnNWZXZlduNGFlVkd6S3Bob0FxdXBNU29P?=
 =?utf-8?B?YnkrYVRmeFpBRTlZUVF1OVhJRFUxeHUzYjRlamdXR2NYZjBYdFpaajZYSWFz?=
 =?utf-8?B?T0xsVTYzQnZ4Tk1hYXJadWtyK01BRiswQW93K3ZtalFVTzJuRFhkc25BVUdP?=
 =?utf-8?B?TFhKRDVrT3dhZTUrWDMvazhNa1NmekpFaUNzeHMvVXU1UEZnYThXVnNlWEFy?=
 =?utf-8?B?RWdZL2dwQTRIejFBb2NzMFR2dk5LaEx4YWxET25vWWlSVjhlNzVWS0VFU2VM?=
 =?utf-8?B?S0E0eEUrK1d1RWpmZVljdXNWaStMekVpTXZQM3JFR25zM0JjRW5lR2Q5b0dk?=
 =?utf-8?B?WGFwcGU4cjByWHRjd09SWld4TFNJR3M5bjFQd3ViL3I4aEpxK0dSSHNxb3Fp?=
 =?utf-8?B?NS8vcEJTUmlka3IxU1lwZm95c0xzR2FTVjZqTVhnbW5BWjBsMjBtNzRpc0cy?=
 =?utf-8?B?Y3gwRURUVGkxQzdkbTc5d05iaDZGbDRLeTVnekM3L2ZtMDI4Y20xaGZETjFM?=
 =?utf-8?B?akdtNkQvdFNHeldHOGJ6bzRNU2l1YW9WNHNLT3g4R0tYOFl4elNmd21kdTlQ?=
 =?utf-8?B?dmc0cFJTc1BtOFVGQ3ZtSU5uMXY0VENaVlEzZU5XVUROMyszSjQvUVFNWXVp?=
 =?utf-8?B?ZzZJaEpRQmdMUzRMWVN5ODJlL1BzNjhRRzZHajh5TW13a1FwcjBiTVhvWXFa?=
 =?utf-8?B?aUNEa21hSENJMGhXeFRyeXM1Q0dJeXlSUEE1ejViL3p1c3VUYlVYTUQ0QjF0?=
 =?utf-8?B?aWtOZU9yalVTWnNMSXdBWHI3RjBOcllNTG1jcUU5TlhUalp6b0ltU3FLbUF0?=
 =?utf-8?B?T3NSd0p0bUJ5SmtiSEZMT2hsalE4eUFDNnVFaVU0MUxKUGM1MEFObFNUNDda?=
 =?utf-8?B?RDFEK0VMaWVkTUx2RlBGQ29mYm5SM0V5NkJBbFZ6ejFLUE9ud1JoYmlaMzFL?=
 =?utf-8?B?ZHlDMnpXR0t5dm1CVnQ5dldiQXF6cENQNHZmc0x1TDY3YW1BT0lkZzlqeTE2?=
 =?utf-8?Q?DP74yOdibiaeoIzpA/YuIEAGY?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ba2ea8-3ae7-49c5-b379-08daa77c3af2
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 09:22:03.4363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9+cBNaUxOzRPBQQIh9I5hGkO+iPB5ie28Ar6A/OoH45NNsQlnj+/UBEBXTt44VFIPirQZxQodvQoDAMu3YWFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7143
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 05.10.2022 20:11, Demi Marie Obenour wrote:
> On Wed, Oct 05, 2022 at 08:15:07AM +0200, Jan Beulich wrote:
>> On 04.10.2022 17:46, Demi Marie Obenour wrote:
>>> Linux has a function called efi_mem_reserve() that is used to reserve
>>> EfiBootServicesData memory that contains e.g. EFI configuration tables.
>>> This function does not work under Xen because Xen could have already
>>> clobbered the memory.  efi_mem_reserve() not working is the whole reason
>>> for this thread, as it prevents EFI tables that are in
>>> EfiBootServicesData from being used under Xen.
>>>
>>> A much nicer approach would be for Xen to reserve boot services memory
>>> unconditionally, but provide a hypercall that dom0 could used to free
>>> the parts of EfiBootServicesData memory that are no longer needed.  This
>>> would allow efi_mem_reserve() to work normally.
>>
>> efi_mem_reserve() actually working would be a layering violation;
>> controlling the EFI memory map is entirely Xen's job.
> 
> Doing this properly would require Xen to understand all of the EFI
> tables that could validly be in EfiBootServices* and which could be of
> interest to dom0.

We don't need to understand the tables as long as none crosses memory
map descriptor boundaries, and as long as they don't contain further
pointers.

>  It might (at least on some very buggy firmware)
> require a partial ACPI and/or SMBIOS implementation too, if the firmware
> decided to put an ACPI or SMBIOS table in EfiBootServices*.

I hope we won't need to go that far; on such systems -mapbs will continue
to be needed.

>> As to the hypercall you suggest - I wouldn't mind its addition, but only
>> for the case when -mapbs is used. As I've indicated before, I'm of the
>> opinion that default behavior should be matching the intentions of the
>> spec, and the intention of EfiBootServices* is for the space to be
>> reclaimed. Plus I'm sure you realize there's a caveat with Dom0 using
>> that hypercall: It might use it for regions where data lives which it
>> wouldn't care about itself, but which an eventual kexec-ed (or alike)
>> entity would later want to consume. Code/data potentially usable by
>> _anyone_ between two resets of the system cannot legitimately be freed
>> (and hence imo is wrong to live in EfiBootServices* regions).
> 
> I agree, but currently some such data *is* in EfiBootServices* regions,
> sadly.  When -mapbs is *not* used, I recommend uninstalling all of the
> configuration tables that point to EfiBootServicesData memory before
> freeing that memory.

Hmm, uninstalling isn't nice, as it may limit functionality. Instead we
might go through all tables and fiddle with memap descriptors in case
a pointer references an EfiBootServices* region (regardless of size, as
per the first restriction mentioned above). (A more brute force approach
might be to simply behave as if -mapbs was specified in such a case,
provided we can reliably determine this early enough, i.e. before first
checking the "map_bs" variable.) Tables actually known to us could also
be relocated (like you've done for ESRT).

Such checking could be extended to the runtime services function
pointers. While that wouldn't cover cases where a function entry point
is in runtime services space but the function then wrongly calls into
or references boot services space, it would cover a few more (broken)
systems.

This, unlike behaving by default as if -mapbs was given, would be a
workaround I'd accept to be enabled unconditionally, as it wouldn't
affect well behaved systems (beyond the time it takes to carry out the
checks, and provided the checking logic isn't buggy).

There's one further caveat towards uninstalling (in a way also for your
ESRT relocation code): The final memory map is known to us only when we
can't call boot services functions anymore (i.e. in particular
InstallConfigurationTable()).

Jan

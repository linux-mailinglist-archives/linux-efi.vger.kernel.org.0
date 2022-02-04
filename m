Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298704A9CE0
	for <lists+linux-efi@lfdr.de>; Fri,  4 Feb 2022 17:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbiBDQX3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Feb 2022 11:23:29 -0500
Received: from mail-co1nam11on2058.outbound.protection.outlook.com ([40.107.220.58]:56449
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230184AbiBDQX2 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 4 Feb 2022 11:23:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EH98jPtE95/l6Uztv4+Z4uQX9pm2THUoL7SSzhNTBoSL7YrqrWYS5TPGffV7Lt1c7grY6BhbfTS+iwe/VHKHMg8sUBsZicbz8zQf2rbIuevUjPSeL9lApanpD7ki14spb47odEbb/d2C8/2dy6Xs5zEBmcoOGwUCefO08Luq+JMwO+bFHkEvjThUdj2D32x/If6KPd2DgzwvyPpzh7hoqTCupne5JEjyp8+BomAY+Ih/qcgGE7QWKELKcQpefIYsnT8jBOWPMxMIzjEMf/hyMTuAwJT1opGzM78eXKcUNwICn85zlt/zPSPxYhbgeVP5rQFS00iKK2D3NfccDdNvGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hhu+e5SmjIeC/0L9rMj8GMcxcCbkA3Yfm9K1vHsLuQ=;
 b=k8l5yjfEKh2D7Ae+E92bZO0/rWG7dIHSBNKOORZVJJaYGxXQb5fVUtfBQABqrPCji2WQxU6/LU+vz9GX+wh/qH/c3IuqssJVr7pHUKPaznBazpgfe2T7OheaANjPwVt2tsmp8qtXXCFNDy8Nt6Y8WwjkC4v1XZhBaMWSccBGqgHT+CT3RsDpefMCRGbUUroEve5H52MVw3AXEf+9jLhLF4kvzfGuaEk1324g7T8aMHet9ojPJxJQ7Clu8mxAYpGclwIvyVVxo/ESTKIoj0XhBjw3+/GqZrxogGgF+rfgzZjD/aX/r9LGnn1CsttFBStOQPqKvloLoLonv7MN8UA+ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hhu+e5SmjIeC/0L9rMj8GMcxcCbkA3Yfm9K1vHsLuQ=;
 b=cj1PPr61dNbMg9dkPaDbRaF+GuOs59byWk0R9H/POxLtdrtJmrn+rmOdgBPPn6rkJY6sSCPtio7jOQQlXUs6QgKFEs4bxZntQwrGgf/WLkU6lWEFULucq1zPkJXcUTaXifp1kisnbLrnwqHe6AFT65M5CIbMG+75b5fGEj122Bo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 16:23:26 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f%4]) with mapi id 15.20.4951.014; Fri, 4 Feb 2022
 16:23:26 +0000
Message-ID: <ec9e29a4-0d2b-1423-d92e-6f025b56f8cc@amd.com>
Date:   Fri, 4 Feb 2022 10:23:22 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v6 6/6] drivers/node: Show in sysfs node's crypto
 capabilities
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Martin Fernandez <martin.fernandez@eclypsium.com>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org
References: <20220203164328.203629-1-martin.fernandez@eclypsium.com>
 <20220203164328.203629-7-martin.fernandez@eclypsium.com>
 <67d2711b-200c-0894-4ff7-beb3eb304399@amd.com>
 <CAKgze5YM2+BRjj2nvb+_dnuCg5WtWvQ6FQyNYJ1c8G6Orn=aQw@mail.gmail.com>
 <5c5ffe29-d3d3-2955-cf78-ad275110f012@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <5c5ffe29-d3d3-2955-cf78-ad275110f012@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0043.namprd02.prod.outlook.com
 (2603:10b6:207:3d::20) To BL1PR12MB5157.namprd12.prod.outlook.com
 (2603:10b6:208:308::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9af20603-6f76-4160-cb57-08d9e7faabe3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4090:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB409036D8A4B3470AB45B5A9DE2299@DM6PR12MB4090.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sn+8aUe0t5rvgK9H8XhSb8R/Rlf95gyj77k1HJfBk4UkeFiOjtBTsbOLQngnrPcowGGmEbclCg6aprQOSZ68coVwTx+x2fv+2ROrKhU3MfX1FohFRyiHj9URlkQqnnIHNgV1zMkMhlqw2o3/8u6CGIHBlP4VVjSKYsAXsjB0tiLC31URu+dg6zinw+v9AAhB3x5gUKIeN6Afn9LRfzlY2JFW+Di+pw1vHgMKiuaP2YsRIswEdrBkbcWL9PlZ0FmDBADB659efyLUoQZqBK/rHc7CleJus92cxF5RhUeSpA65x75nZMd21i5czUa5se2kemJ4Y1j3nePDEnKikVypfnzzPT45IRMq/PkWm4HUTeTPWpQzJOEmDlsAWIESN9i+zbYbhWy7Voq6HNJ8u/z29UO5W4RgLFHEHVzQXI8AM+bQs7PgMcmOCDOmZMtrFc0BGM2MuBksp7by3f7KLVj46P3/r6a1TFK9Zn2h5dkvB9oIL9YP+pG/odDQInaO1xvlOmYBN98CtWS5IDHbTAnufgTNkBMWVxRbbOpitriG858Nt+yn28hlJWq3JD7Gc+f1nKM91N2Kdwii7Uj6lHRdgUF1pA4oSsATXkNLmyf3w/pG8fWvD3t1/MpfWHnSQSCFCkOv1tbebWqXvkzpxTHRi52tkQ/1cLZRBGZbftRRpkmTkIbfZBtPeakKvdp014X2YttkXrQeO2SaGMvU0nvwviM96lXAFsRovrbOqir2UU8oASM0zk+Rqaq8HbF0hm8YiDnJF/oqDHSaJLD0gon0nBk2acGtsgAe/KBTo/FSCIi4KXcgQGglyRhfGlxO1C2X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(66556008)(8676002)(8936002)(4326008)(66476007)(83380400001)(66946007)(7416002)(5660300002)(6512007)(26005)(2616005)(186003)(36756003)(53546011)(6506007)(6666004)(31686004)(86362001)(31696002)(508600001)(316002)(966005)(6486002)(38100700002)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anJQNFgxT3dMbVZWWkUzMUlCN2pvSnR0cnRWUi9uRHptMlEvSjE2aFUyVnZB?=
 =?utf-8?B?bCtuaEhwVXloUzYyNnluT2w3SDBrNzhwK1Z5VmF1QVJGSGU5R1RuSGFuT253?=
 =?utf-8?B?dWNhZDYrc2hxV1FYZjM4YkdXNUxNWGRzeHQ5TC96VG1xY2Q3S3dYa1BJZTBZ?=
 =?utf-8?B?U2FWaWV3cDRYM0NPQWg0d2s3cmZIS2dDVEJSSmoxbnhCV3pVT2ZaWWkwVVg2?=
 =?utf-8?B?enlnUVR4ODlqUFZ5VlQ1dWVwVXl6RFljcEZuUFZYcHQ4OEtBZ3FXNGRxWmtu?=
 =?utf-8?B?c20wWXJaTkY5aUo1MUlLTFZGVDBhQWlvWGE4cnlwVnFkbUtkbzVydTFLM2ow?=
 =?utf-8?B?SVo1Q0lVbk95a1dGYTFaeXcrZEtMSzdSSkZtVGtIWE5aV2Y5L3RXYVdDUWFK?=
 =?utf-8?B?d2ZwWnpVNXdvdWxRODJ4OG8vc0U1dFRZdDlVUFBnWnI3U084ZzBCdUJUWE9Y?=
 =?utf-8?B?YVgzMHEyVU0yUFBraCs4RUpCR2p0SXRRdTM2TW5zYjVjblByTDY0d1hVcGxK?=
 =?utf-8?B?Vlh6MXpISVBtT08yS3lPbHg3TmRGWjFzdWxyNy8zSFNmcXNiakMvK2xsdGdW?=
 =?utf-8?B?MjYxQkthS0ZXTnpIeitoMlBBblVtbXoxbVZteVQyRE5OWUJiWWZHUHFLdUhH?=
 =?utf-8?B?K3R3ODZOc01ETmpxajdTVzBVZTZqcHBWbG56OEk4K1dBZ0JuOWYxek5NM3ZR?=
 =?utf-8?B?U01ydi93WUlzaEZlSTM0NU5GNEcxb2xpYnVXR3VmK0ZWR0RTbFNSTldVTk9R?=
 =?utf-8?B?SEVvbE83NkpXSmRWTWxraWFqbHlOc1dYSlBsMGVETk9HbkFhNi85dkJJallp?=
 =?utf-8?B?NzI5dHN5NkJjSi9OUDA2eDVmbEprYThnaE14Mk9Qc24vVHp0QjdqT1JndzhT?=
 =?utf-8?B?L1M5UUVUWHRBMW8zR2w2SW83cFFhUHREQ1ZIVkJndmxSYTVvM3BSamcrL1dm?=
 =?utf-8?B?Vk85QXo3TXkxZklPWndEd0NmMUJObjdtOGNJUDRzZDdoaW9lQ21EZFNwaE83?=
 =?utf-8?B?V3RIOG93WkJhVDA1ZTdUR01LMGxBejhwSGdDK0ZSVHVQMjhCR21BZ0tRSUwz?=
 =?utf-8?B?VEpqZHlRSFpRMFVlb0dMbWZSdUJzRis5akRHNURjUy8zR1pLZ2dRdi9kZTFH?=
 =?utf-8?B?QStrSWNxZkE0amRDVnQ0M1pkTXp3NU83NTZxVmp4ZWNXNDNVdzRKZ3pqKytH?=
 =?utf-8?B?cDYzcktUZ203YTVvWVg2TDNsSkZrZFJzWFNHUW1STUZ2RzM3bHg1K0dsWWto?=
 =?utf-8?B?MkVwTGFqbWxnVFVWZkdnUFAvYmIxY29NNkoxeXZ2c0FXU3BvTjZSOUtydk9Q?=
 =?utf-8?B?Qm9IQVJ0TmhEVzh4MnR2a3Y1MEtQRE9NTEIyQXEvQzg2TEtFeE5EWVB5Zm5W?=
 =?utf-8?B?SytaTC9NdFhBYnZyZnhXSU9ocTZ4cVVia0ZUUWdQS3NnNllHQWE5eDcxSWdl?=
 =?utf-8?B?OGJQK0FsTkRuQXZKSXA2VHlsM051blBGdTVLU05CUWZVMWk0R0ppcjA5c1dJ?=
 =?utf-8?B?WkM5dWwreS94WmJjYUVabFMyeHhTLzF1eDc5emVJNWE1Qk9Na0xBcDVpdjN5?=
 =?utf-8?B?ZVo1cFJJRDI3djRXOVcyYk9hYUZxNDBwYm9GSmZudGgyclRxR0NpTzNzMTJt?=
 =?utf-8?B?UHhVK0g4azhmOVluUk9TdGNiRmErd1ZLdzd3a1plV2pTRWpteEFGNC9LVlJt?=
 =?utf-8?B?U0lSR3hLSW9MQ3JtSHI0c2tEd0x6eUxSYzBLRVdWR0hMclVXZCtRejdZcCtl?=
 =?utf-8?B?VDh0MkpPanBRTmMwR0huQW9vVW9OejNCR2xEeE5qaWN3SHg3UGZpL0c5Vzk1?=
 =?utf-8?B?V1A0Mm9heFBmc2psQTZNSFdlYUZNdm5HS1pHS0lCV1pYVFE0UDRpOU1wdVV4?=
 =?utf-8?B?OWlhSUc4bW1QN0plSVdjcDNRQm5tYkxpdlkzblhlYUxVdnh0R1pvSG9nRFJh?=
 =?utf-8?B?VEVtVE52Nkh4bnZralNHWmQ5ajQ1bjFrcWtDZndWSUVzaGhZazRiRUpZYzRI?=
 =?utf-8?B?ZVJnVE12UktsK1lGSW9VYm1IRW9RdVNhcnZhZVNSbnk3YkRyWjhYQi9ORTQ1?=
 =?utf-8?B?M3ZETE5OSmVJWEJuSnd4WjlnSnZZaVVHTU5ZU0s5azd4NEdqWmxEZGI4T3hZ?=
 =?utf-8?B?aWRTWmovQkRsS296eWJlT2JwRVVyUU53M1FEOG1xQVNISkYwbzFYRDRvaTdw?=
 =?utf-8?Q?gP1qjwH0V/QSkhW4bKdeLlM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af20603-6f76-4160-cb57-08d9e7faabe3
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 16:23:26.4433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0dJB+9kZYJjALLKzz3NAa+9WzB8YlPWu0iF7WDSLFAHR4fz3eJo0UWf2uL5EgJiyd9XXaYT2Mwv9xrUaYteyjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4090
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2/4/2022 09:59, Tom Lendacky wrote:
> On 2/4/22 07:21, Martin Fernandez wrote:
>> On 2/4/22, Limonciello, Mario <mario.limonciello@amd.com> wrote:
>>> On 2/3/2022 10:43, Martin Fernandez wrote:
>>>> +static ssize_t crypto_capable_show(struct device *dev,
>>>> +                   struct device_attribute *attr, char *buf)
>>>> +{
>>>> +    struct pglist_data *pgdat = NODE_DATA(dev->id);
>>>> +
>>>> +    return sysfs_emit(buf, "%d\n", pgdat->crypto_capable);
>>>
>>> As there is interest in seeing these capabilities from userspace, it
>>> seems like a logical time to also expose a `crypto_active` attribute.
>>
>> I planned to do something similar to this, but to show (or actually
>> hide if inactive) tme in cpuinfo, just as Borislav Petkov suggested a
>> few versions back.
>>
>> https://lore.kernel.org/linux-efi/YXrnkxgdjWbcPlJA@zn.tnic/

As Tom agreed in previous post, Boris is mistaken here.  I just double 
checked on my side on a workstation that supports SME and comparing 
/proc/cpuinfo before and after SME is enabled via mem_encrypt=on.  I 
confirmed that nothing changed.

>>
>>> Then userspace can make a judgement call if the system supports crypto
>>> memory (`crypto_capable`) and then also whether or not it's been turned
>>> on (`crypto_active`).
>>>
>>> `crypto_active` could be detected with some existing support in the
>>> kernel of `mem_encrypt_active()`.  This will then work for a variety of
>>> architectures too that offer `mem_encrypt_active()`.
>>
>> I need a hand with this, I grepped for mem_encrypt_active and nothing
>> showed up...
> 
> The mem_encrypt_active() function has been replaced by 
> cc_platform_has(CC_ATTR_MEM_ENCRYPT).

Yes, thanks for correcting it .

> 
>>
>>> As it stands today the only reliable way to tell from userspace (at
>>> least for AMD's x86 implementation) is by grepping the system log for
>>> the line "AMD Memory Encryption Features active".
>>
>> Isn't enough to grep for sme/sev in cpuinfo?
> 
> No, it's not enough. Cpuinfo shows a processors capabilities and not 
> necessarily whether that capability is being used.
> 
> Thanks,
> Tom

Tom,

Maybe some sysfs file(s) directly from cc_platform.c makes more sense then?

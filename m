Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92FB5AE030
	for <lists+linux-efi@lfdr.de>; Tue,  6 Sep 2022 08:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238328AbiIFGtz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 6 Sep 2022 02:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238631AbiIFGty (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 6 Sep 2022 02:49:54 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80079.outbound.protection.outlook.com [40.107.8.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618E111839;
        Mon,  5 Sep 2022 23:49:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxdsSNymekpT7hnaqzpdixTjHKlV2z4d5v+0xT0cYKo0xvHGVQGqY6u2QmUIZOGkk8lQwP15VQjgh6OH8qOmwm/IJqDWP2pLUDhBc5nqHps9zY6uhuEvPw8el26RI3cuE56BijjCDT2tE2x6NECSetZ6ArGSxKGPOUttIlsyZakdJCJZj5UbU1VRIfCokjXpZaau8jo3w3R2GIMsiHCxBFDSLw7pkRVDYL93ZrrPeiUoSPDOA1IPhqMNpr337mvFCBCp6DOONjLr8snjJlrv+TsGZRdiNSODedCheZb0OTihgzRrQ5sRB+XUHoDzha5KFkzlNl91r6mT0nGISKc62A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daJ/X+yeFCczqqO3r5A3SgYuveEeP1d45cY5MyHiEUk=;
 b=WmSs5B+2MLu0+CdyxT3RngV+FIor31W/JIjfotcLWAhlI1cwdDFUNqdBj1E6aSKCJnFNpLy/Zqe9HRsn/kyzVbDWOq3E1ETSEyJxCsTXkiLuZkp6FZwdMZDw1wp7s0LJR9IRm4koFbffUgHzlErx22a8+4ezMemHHnsAMTlcPxLIy/xn4jsSpevlV1qd1QtQljnCiHeENrUm08cxvRyyWH/V/QtuMPNnjPoNLsSM9Ya7D+8ZjglqaY12tSitVAMBorMs+k0FNVjOTTEpw73Ld0TJUIbPKjJsJN7KGI1OLbpaw1AIX1ZZcqiOBrRNRZ/NtHUzwbGgxyfeRS6bUfBOhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daJ/X+yeFCczqqO3r5A3SgYuveEeP1d45cY5MyHiEUk=;
 b=KYEVX/Z3IHXIkthgDDPvZoal2FFKm87kGofPS5tHRVqbE29sPmx/tPQWyNPus/KVZXpCGKjDDpvNNvM7rXWjfvZu1TlXSuuJx4ygk2RwEqL30KQXdrncxpdpLMojBsatz7A3Qc7uwudfWnNYiOEyB6H/ggPEdpEStuevC6/kiwBV8ULsRM5OZBBuOxr7UXn/eKlksk+JlazHi0N2Fsgip7tOh5UhSqQu1pg20y2eCrC/V0TNMbfJ0t+eh7A6/9CYRzW22NKQo4IuBPLx9UpX/y9SxYEIYxBWlpH/QuCkQPh4+3EKQFP/amnJlWjE05B9Kpf0VS+YjHbTGKXbXOTYaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by AM6PR04MB5957.eurprd04.prod.outlook.com (2603:10a6:20b:9e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Tue, 6 Sep
 2022 06:49:48 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::59bc:901a:98a7:76d4]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::59bc:901a:98a7:76d4%5]) with mapi id 15.20.5588.017; Tue, 6 Sep 2022
 06:49:48 +0000
Message-ID: <2a1a9e8c-0635-e207-e858-0e0bd1df0f11@suse.com>
Date:   Tue, 6 Sep 2022 08:49:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] Add support for ESRT loading under Xen
Content-Language: en-US
References: <20220825215218.1606-1-demi@invisiblethingslab.com>
 <c2a22672-b9dd-7aa4-b61e-ccb0faaa3b01@suse.com> <YwkKiFIKHG4IcCmH@itl-email>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, Ard Biesheuvel <ardb@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
From:   Jan Beulich <jbeulich@suse.com>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
In-Reply-To: <YwkKiFIKHG4IcCmH@itl-email>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0090.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::15) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 873354b4-52c2-4fec-83eb-08da8fd3fdd0
X-MS-TrafficTypeDiagnostic: AM6PR04MB5957:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: af4XOKthSQacd31g1ISu8sMiz16UWmsIxi2H3DPVJZdS0Loo9xECuyUTLITeow2MeOp468FWWcZ9MrjuliayNlGLOYOK5zLvdHXvE61ZmS4zXhbchBI/RMmLCMf9J0CiLyZ8h4GNJLGuAG3tRuc894DwQ9RZgurMpxjWKwkzwdPcs69E96nyum12NjCQxEyeCAhNDGLonv4JJVkJARZUCiHSsyPgeIADZP190uWRAmH6QivDQeJ2VeCS1vGQZ+2aglCEtC59vKbP7PRbGfXhMu9qF9V4UBHViolNvLL21r+zaPwHDqGn/q7+1Ll4JfzA70eCZRsRLkgbe+E3Lklwq6TRsaONZJqZPEggelFlplBPPytODkOOam600Kk9uoysThyBurCIOd8DM979qDtBUNI6+rn/knjbTcAa4L8rtMSGsF4pWvLeDyF0N9YR5bmxHkN8rlgG0IaPRma4YfjVF0X8oFhzV72jKJyT1soMjEIPFWg9TWPoH2Aib8moGfPKacL6JWuJvaAVeIrVqXFI6HgIhJ3hYUC4n+P3MrrsVBUJia4WL6oePQo+bIml47oeFmnDSpahhxXXqtkA3kSSQPh0YVGztvO/ebIUKgYtJxIrfWZT0twiRUKfaUnXoc0k8aHQ7hq8el3EplY40ko6eguPn2zYd4aU014TTmOFkpTMubf7hSzUIzH4Cnid2SG5IWqpYTvaoag6jronXQcVBBjIjnrNVusucl/paTRlBA8x7jqXQtoD9Hi2oobkpgvt+H3/1CUSDY+94GXHThP6LBguZmvf9yVxowipoGhmHG4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(396003)(39860400002)(136003)(346002)(36756003)(38100700002)(186003)(2616005)(4326008)(8676002)(66476007)(66556008)(478600001)(66946007)(6506007)(83380400001)(31686004)(41300700001)(6666004)(6486002)(53546011)(6512007)(26005)(31696002)(86362001)(5660300002)(8936002)(54906003)(6916009)(2906002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yzhpc2d2K04zMDYyZDUrZ0JZTXFFWFlzL1c4Um5sNHpvQjdvSmhHVk5KRmEz?=
 =?utf-8?B?cHN3MmxSQTVSbnI0elp4R0U4cEhBT2NnanA5eEpQSzhSOFd5OGNoRFVEUGZP?=
 =?utf-8?B?eXlpMFV4WlBXcnhnU2ZCRndxMkl5RWtoOGR5YUVuUjZpYzlnUkhTL1VhZVhU?=
 =?utf-8?B?dTJFTmhabnJNL1lxNFF4eUFqVURNSzFkY3lia1hnQ0JWdUFEbXJFTnRuQi8r?=
 =?utf-8?B?M082bUNxWmtwdUdaOExSR1loZ29rVWlmL2tmTVY2ck9NTXJpK3FmR3k1UmNI?=
 =?utf-8?B?VW13Wm5rY3FkNjM0T3VudFhvUkJQcDNUcHpnbDFsTXQwM2I3dk1hcGRYT2Vj?=
 =?utf-8?B?dFVmdVZwZWFVSHdKbzJ3ajg3UWtUVHF6Z0x6K3BSdVF1Y040bXE1LzVnQ0dV?=
 =?utf-8?B?QjNVSG1HRmhBMk8vQm1vNTI5bXpnTGVJMTl4eWdKenppTGV5N1h2cjZkUFFO?=
 =?utf-8?B?R3BITzNlemdOcXp6OEQ3ZzYyQy9wQjdFTHFmdGx4MVM0WFhoNUhydGtPcVRV?=
 =?utf-8?B?RnhQYUJnTnA3QVNZMi9HbjdhNTJWNktYOGJURzFlRE1YTVlpRnVKc05ISGJB?=
 =?utf-8?B?VDl1MCt5c09qYlpuREZyZXVieVNrNlVjOGpzS1hTU1g4eE11S3Jmb3ZMMGRN?=
 =?utf-8?B?ZG5peitESEdzdU5rY084Z1NzOVR4d2JBQVRzbzJqdlRPSDJYYWJvTDdXRnJ1?=
 =?utf-8?B?cWZCa0ZPeVFINXk3S0srK3BnUVRVS2Q4YldEODJpMGlPa3VpS0Q4VTNPcjVL?=
 =?utf-8?B?VG9NRko5RDRBTVJCaHVESWFRczlzUGhua0wzYm9yazdsMXlYd1ZRS2Z0Uy9s?=
 =?utf-8?B?blJsOWVEd3hNaEp4L1pNOVMyaWYwcExRbE45ZHhlczB0L2VPclV3NElQVjJL?=
 =?utf-8?B?NjQ2SncrYUtOL3BTejVudndETytyS09oc090Rkk3SHkxd1c5QWptZFJLK3JI?=
 =?utf-8?B?QlcxN1lmZnN5dU1ERk16SDV1Y1hqa2FnQXFFVmc2SHgzWGRIL3JRZmcrNTBT?=
 =?utf-8?B?aFJPV2g4ZTF3bzNiUitFZkI5Y3lkZVVNZDZ0WWdmdFhrSk9UZnRza0ZPbEJz?=
 =?utf-8?B?akExWUVNUm1jK2U0VXFIaUJhWDBaYzRGTFh4cnFiMjN0YWI3ZmMzYVhjRlov?=
 =?utf-8?B?RzUzTEFNRFM5R3QvRVNWYUtHREFidmMvQW43OEdNR1NoUW1kcmN2Yldsck8y?=
 =?utf-8?B?eFNzUVozbGxMZHhmWVJoSlNybGhkZWVFbndBdjU5bEFmcnVJZDRtNGxXVmhy?=
 =?utf-8?B?MUY3L0ZUTmMzY0xTVlZ4dHJLVlFpUEQ0SjdONWh1NzZIOHZMN0lRWC9PTDJG?=
 =?utf-8?B?aGx2RHVLQ2Q3VnNEMk5kR1ZlNVFBREJjN3lrVmdwazM5WTRmd1plQjI1NG5s?=
 =?utf-8?B?Q1MyTFFaQnNsUWJXdjFub3RlTlBEaUZkSlV3Y3BhSm1zejBFcXJYd2hlWU5S?=
 =?utf-8?B?Sm8vS0VreWxxT2xyQmpPQkFyOG5QcUtHSDJRKzg1WVl0dXZPU2xadjVzYnoy?=
 =?utf-8?B?K2d6MFoxRURDanRzSmR5YXZTWFk5b2RRUTRYU3JKZXVKOXEzbThmRXdxMXBY?=
 =?utf-8?B?d1JWREJjaFBkekw2R0xaU0JFb2JBN0F3Y1JjZURRVWdrNFVzbnp0L05zaFFl?=
 =?utf-8?B?SjNUNUpzS3RCd1hyYVhpYzYvQWtYT2crcFBGc1kvaWJmTDJrMjZrTXAweHFn?=
 =?utf-8?B?Y3lGNjIydHl2ME1pcTEwaUFEd3U2NlY3VGhhZjZ6TVhCOHRiY1NyZGx1R1FP?=
 =?utf-8?B?bThsUzNkRktOQUpKd1pleTRzbEdENFJRMXV2Y2szd2ZBUHBFMWE3UDZrNGw5?=
 =?utf-8?B?ZWhSd2xLWnJvNHZlRldURi9zeDI5bE9NL2pheDBwYWYyTU9EbGRHUk41NXda?=
 =?utf-8?B?ZWVWNUhzZytzYzR3ZkpYbHdWNzlqNzUrS3VFNEVuY0pIKzhNZ3VLVGh1T25x?=
 =?utf-8?B?YTY3Y1BXaENHbzZUbGNHUnMzRS9QYWxTQzNRbURQLzFsS0ZMZDkvLzY1Y1ln?=
 =?utf-8?B?eGUyN2g3cmhCYTJHR1FiTnVUYkZZUlh4Ym5ldVNTRHVMSmFjNHZzRk05WHA1?=
 =?utf-8?B?R2x3SjhXMFh5OEtKcHc3MENrSjljSWFRaWNxdlNMcWozQUlKekxkR2VtWVZS?=
 =?utf-8?Q?XhyRsPqwArEtAWnsw509J8B58?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 873354b4-52c2-4fec-83eb-08da8fd3fdd0
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 06:49:48.6925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gET1Fn7mGvp0kv5bOWWgOI7f/Eg22s1VejON6ag5JlNgleCb01PDAcjGZZ/pR8gvfRl/lQHzqY/kbKdClIiZcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5957
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 26.08.2022 20:01, Demi Marie Obenour wrote:
> On Fri, Aug 26, 2022 at 09:53:29AM +0200, Jan Beulich wrote:
>> On 25.08.2022 23:52, Demi Marie Obenour wrote:
>>> @@ -40,6 +41,38 @@
>>>  
>>>  #define efi_data(op)	(op.u.efi_runtime_call)
>>>  
>>> +static_assert(XEN_PAGE_SHIFT == EFI_PAGE_SHIFT,
>>> +              "Mismatch between EFI_PAGE_SHIFT and XEN_PAGE_SHIFT");
>>> +
>>> +bool xen_efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *md)
>>> +{
>>> +	struct xen_platform_op op = {
>>> +		.cmd = XENPF_firmware_info,
>>> +		.u.firmware_info = {
>>> +			.type = XEN_FW_EFI_INFO,
>>> +			.index = XEN_FW_EFI_MEM_INFO,
>>> +			.u.efi_info.mem.addr = phys_addr,
>>> +			.u.efi_info.mem.size = ((u64)-1ULL) - phys_addr,
>>> +		}
>>> +	};
>>> +	union xenpf_efi_info *info = &op.u.firmware_info.u.efi_info;
>>> +	int rc;
>>> +
>>> +	memset(md, 0, sizeof(*md)); /* initialize md even on failure */
>>> +	rc = HYPERVISOR_platform_op(&op);
>>> +	if (rc) {
>>> +		pr_warn("Could not obtain information on address %llu from Xen: "
>>> +			"error %d\n", phys_addr, rc);
>>> +		return false;
>>> +	}
>>> +
>>> +	md->attribute = info->mem.attr;
>>> +	md->type = info->mem.type;
>>> +	md->num_pages = info->mem.size >> XEN_PAGE_SHIFT;
>>> +	md->phys_addr = info->mem.addr;
>>
>> As indicated in reply to your patch changing XEN_FW_EFI_MEM_INFO in
>> the hypervisor: While this may fit the ESRT purpose, the address you
>> return here is not necessarily the start of the region, and hence
>> this function is not a general Xen replacement for the non-Xen
>> function. Therefore I think it also shouldn't give the impression of
>> doing so.
> 
> Is this just a matter of renaming the function?

Besides renaming the function perhaps it also shouldn't give the
impression of being generally usable. I would expect it to be a static
helper somewhere, or even be expanded inline.

>  Is it possible to
> implement the original function with the current hypervisor?

Yes, but doing so would be ugly: You'd need to "bisect" your way to
the start of the region.

As an aside (I think I did point this out before): Can you please
adjust the way your mail program sends mails? When I respond to your
mail (using Thunderbird), I find all the people previously on Cc on
the To: list, while your address is lost. As indicated I believe
this is a result of the Mail-Followup-To: tag your reply came with
(and I further think that TB's treatment of that tag is a reasonable
one, albeit perhaps there are other reasonable treatments as well; I
am not aware of this tag having any formally specified treatment).

Jan

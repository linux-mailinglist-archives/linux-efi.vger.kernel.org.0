Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203A85A2259
	for <lists+linux-efi@lfdr.de>; Fri, 26 Aug 2022 09:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245712AbiHZHxp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 26 Aug 2022 03:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245737AbiHZHxk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 26 Aug 2022 03:53:40 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01DED4184;
        Fri, 26 Aug 2022 00:53:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZ+EGh0/1polVxEtbGjIWbltRlOk8UNxdpnohf4PxoJj5qA0bA+V4oLLLqhEMVqVvQflN4XferrXv9/8UUpIVF6gw3xnLVYpX5hjrAMyL2mG2hAHbaw6CWKPgQJzM1xOE+2tGq0UyfU9YoWAIqoojeZNSlKWSI+tIPLO6JGC+4xtfWCaVNsOI2HUGEqQuJrw/LgxrcCFQqL8UWPfuxE7tPoRyW3QKl88Dw9qMi7gGe60ZxeDRBWccBPX6LFoTMOZFCh+gsMzp9+dbR+icyqbbP6NMUJgr6jkC6oha10/0cOQ1/GdIt25YYqIke4CIFadt+o4x8PO/MvHSa4C1/VS1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8CAIP1LbzZfdOfsH4p172fNfYeWMO79MKYu4mbRFYo=;
 b=NwzVLcLYTXNhpZCAWOl5fdhe9ZUrf1logQ8HrIgmMPpZe376PP7ZI+bfKFbwIo2w2YjzcbNFwpoqeF+SXok7H6yAVYBBaaRdp8fG9zwRC3eZ3zjadAwndD8dIs4w28iJJNca7LEFIu3fMVA6HUumOFBBxzDLyGnQPDsD6/qpMufFgTsvjP6yH193OEMH6kH5FYsmUTggoL3E7O59Z5sp4caADFJkkAuefzSNqhKzhBlZXNHOVJ1iG1h7Ucqz561F6LnIf/wL1EuUrCWnzSZ9N+frLNo7+f3qJaID3DyLjxyvsLBJ3oIUIhg/BgRwcUurLF0wSpliQOrOJaXzMvmbGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8CAIP1LbzZfdOfsH4p172fNfYeWMO79MKYu4mbRFYo=;
 b=XoZMv3LwyA1xogPB4mj7Iaw89ylqN8/lcynhZs3zlbhc0F29Lkoejkye7CBy3bVCVJk/0FPvCXc7zt2wTxMyJGKHrvsxt9vfhP4iTCPtKcZrKe4tVYlQz+F85bSYyKZlvhM7hVm3mkjf8vNo9+4+AUwmSHLh+2ncMG4fVhTjKvAh3wwoGJ2uT1UUG8TuO916ec34yI8mRI5RPqtvxZL2KXEbzhMBNXbjfSQJg99CFjqq5vZk1qjTl+VZUxFnliDddqbJSw+Ul6GgXK9bHvvffpNKO1B5qAquaKP05H1ajkio6uoRGyHf903ZExn1dGXomztbDSIlgXe3h7eOOx6e4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by VI1PR04MB3167.eurprd04.prod.outlook.com (2603:10a6:802:8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 07:53:33 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::2d5d:bae0:430f:70ad]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::2d5d:bae0:430f:70ad%4]) with mapi id 15.20.5566.015; Fri, 26 Aug 2022
 07:53:33 +0000
Message-ID: <c2a22672-b9dd-7aa4-b61e-ccb0faaa3b01@suse.com>
Date:   Fri, 26 Aug 2022 09:53:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] Add support for ESRT loading under Xen
Content-Language: en-US
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, Ard Biesheuvel <ardb@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
References: <20220825215218.1606-1-demi@invisiblethingslab.com>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <20220825215218.1606-1-demi@invisiblethingslab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR10CA0035.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:89::48) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2023826e-6da9-4207-8a70-08da873812b6
X-MS-TrafficTypeDiagnostic: VI1PR04MB3167:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: luVbnwBHuA3Ju0iVGWgquCHV23HKwvhdcB7yn3mfvG/szoZJ7iWI9Wt84vdPAEGjC222Nctzpv6dTqUDYehsquSfdxcAQEZhQ45Z7zydSyeaIuGmcXMfHGj6vFya4ZkOMBBi6oT8eu2VGoPdEOm/hj+LqdNoVdALWjxt4R7siK5WzGAnzYCyydfrr+khJ/DOPNu0RrTuk6mccBVpBvtXHbqHhXrIW7anyFgJ0mUE7HK8QzA0QWZ8jce9rFBnPPpQ2lPCLdJEyr2YQwhXg33OHdoFKWpMkLWMNi7FJvB4ZbcOJokSTFVj2oo6kwhRniTgqzPOMMaQ/4GhQRCcFjFWF+W59B15mVOHN/abtMXw2/BEfFGAc1wIHf6u8M2FDYdp0fDvI54hPK+6LyUFRqFqQRIN3A4zIphWiDbpcV5p/U3oQ0bh1b/vPhuQzQrozKrTfjTQaz8NEEeEw64uNV/5Ai6Tc9PBFnUw0GRduQd23oM7aV5dgOpFj/NH69e50qZuxm0xaugdUb/L7OuuuXWUD5dH8LnK0yVJrjhe+Gm0V3GfTME2BbKMrRvXYIFZ7GkWg58LRg5fxF9bUjJoXtDdAFsDFZc2ta9f60Gn+hL8t4ZNMP8h4nZxfnjNOzOX8xmLmBc+rhA1DltHrMB0Th4/cxqQIY9eKsz0zO3casUA0MYD6J8S0LWsohMe1F8x5foPkwWuuOYrkiLkKW9+riPSg96viZp/Ib6bajQnhxt+XSRo7fVc0s91gIc6RGnBiXDtzN0x9WKa0o6Ewdrvsk/DfjuN8eVWnySmcSgFQivODRE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(396003)(376002)(346002)(136003)(66476007)(8936002)(5660300002)(4326008)(66556008)(41300700001)(31686004)(36756003)(478600001)(66946007)(38100700002)(316002)(6666004)(8676002)(54906003)(6916009)(53546011)(86362001)(6512007)(2616005)(186003)(2906002)(26005)(6506007)(6486002)(83380400001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3pwSjB6SUtrdnQvODNmS1BoWFMrKzFNbTlTVkMvWnlZZDluc0ZZZjJ3QnYw?=
 =?utf-8?B?ME5HYlpBWVY0K2NnTXIweG9CMGdXRlIzOU5vbGtJRnpkUE5rdjlScW1oMnpM?=
 =?utf-8?B?OW9nL1FzODBHdlJQMk5jWjE3aHZkQjhTQ0JvTVZIZys5dG1NWksyV2o3ZFZR?=
 =?utf-8?B?V3F1WU1vVXRmQ202TWQrUHdnMW1TYmpEQ2oybnZGaURwSFZJSDhTNDhibFBO?=
 =?utf-8?B?RWc4VDhQd3lWWmNTN3hTcGthSW9hNUR6dUx5dUM3K3NJYVVIZ0hKZEVaRVhh?=
 =?utf-8?B?V2w3UWdaV0NFVTkrUmdlNDk0MGhTUU5PaHdBVFpRRGFLTHE2V3Y0QlY0T3ox?=
 =?utf-8?B?NEZtem0yMUd0QXlCSUdmZ0NFS0V1ditoRUFxQ015OVlFM0hscHYwNTdZL3Jh?=
 =?utf-8?B?Y2NIaEtrclZ0bjNacXR2N2laQTNZWG8wS2dVdGxGSnQrVUNDNHpDZEJOWGpp?=
 =?utf-8?B?S1NmOUM2R2ViQ2lObHhwLzFmd2VFbndZclYvN0xFRVAzWko1UGVTS2FIWFFa?=
 =?utf-8?B?d0E0MlBGVmZFcS9sTXhNd2FOVjkzZVVZQmQ3UTlEdkVJMCsyc0VWOHhkbm1C?=
 =?utf-8?B?S2tJTncxTmFxc2xxdk5Db3A0TnBka1hWak9OejRSQXB1QU9JVWcwRzlwQnRY?=
 =?utf-8?B?RE8xMEN5TGJ0aWFtU21Pc3dXazBObXFRaXc5bTdBRUovdHgwcjJXWlB0TVA1?=
 =?utf-8?B?bEN5WnNnOXZPRFBwZTlCUWJyUG5OWFBSempsMWV0ZnhZSzJuZmVoLzBZVVdB?=
 =?utf-8?B?VkZ3alphdGlZQUVNQnc0SFc5eE5zOVp2aTBBUW9nUmh1S2ZocUdETXBBZXpF?=
 =?utf-8?B?YnpwTmw5ZG9qMmFJV1dPSHFyMGUxRUd4RFdoVndVV3pDUXpEcHpGcFl0ZlZB?=
 =?utf-8?B?VFYyOEpielVZYkdMeHV6cVNBbUs2b3NNQnhqT3pOQmZ0SFROd2xsZnNaVFVa?=
 =?utf-8?B?VkVLbnhRMHFEb2d5UEIwSGhRNTR6S0JxbkVxRDRvaG5mWmFzMkZLVmhDaG1X?=
 =?utf-8?B?d3Y1L1pIc0dsWm1oZEJ5ajFqSEN2SXpvUFlpODQyUmZmT0EzdVRqYmVpOXgw?=
 =?utf-8?B?Y2ozN2pvYmVTRTBaT05Rd3NSVVNvTmhyNUFqaVVXMUh6NDhwaFF0TFJubVNN?=
 =?utf-8?B?N1dGMTFVMEtVUVlSUVBodWRNT2Jnb1ZZU2lCR0xvSzczSm1EWTVPNjBKZDEv?=
 =?utf-8?B?M3VVY1dVK1B0Vnk4ZlVrbGUvMUE0dndJWGZkZ3N1Qmwwb3lZSjNmYmtiTTJ4?=
 =?utf-8?B?Z3R1S1dnbVNNVi8zTG9JRDQ0MjlRTHFYMURXTjFEWXdReXdzekpwaExiN0RV?=
 =?utf-8?B?SGJ6UEc5eS9xUTJBbThZYll1NEEvdWFSeU8vVGkxK1ZyUDA1dDY5VmlqbUtj?=
 =?utf-8?B?TldjVi8zOWt5OThGSlZ5dDByenpwVjdaaysza2VXbWZyNE9YRDQ5T2t1dHlC?=
 =?utf-8?B?TGVUOFpsT3ZvSXlaZVVkRFFtem8vNmxMTGdiZFAxa0VPdFhZSVhMbHpybDZO?=
 =?utf-8?B?ZDkxQ25uWDlXWkpMQldCTmNvUnc5bk5BZkJFWkFmejBIRUREZGpTT24yeW96?=
 =?utf-8?B?WVVzNlJ5MW0zZEF5YlhsNk1ZdUN2c0VKazlUMHljekg0dTY1bFNDK29FcnBM?=
 =?utf-8?B?UlE0U0ZpejZvOEpXbUpqQ0hlSCtBTWxNL0RqUVN1c0JteHFLNjFUdXhUd01K?=
 =?utf-8?B?eFNvcW9qNE5aeXZacHFFV1hnWUk2bnNGT05EajZ6NytrWDMyZUdwTzhTUlNS?=
 =?utf-8?B?VTN4MlVTa091RXNBcWdRTHlnWTFSOUI5aU5rbnhDeU8zQ1BQVXd2N2g4cURy?=
 =?utf-8?B?bFNScFVXNDRPWjBtR052N29xK3k0STQ3d1JJQ29iM0xJYkZwZm1nc0ZHQzZs?=
 =?utf-8?B?UG50cVVyVVBqZWVERTdheVJpS21pUDU1N0cwZVg3d0pocFNLU3ArOEF0dHZW?=
 =?utf-8?B?bHlMYmlPY0lUMVdVM1JYUTVOLytKNmJIUEdyK0ROakNqeVM3eUkyWmFiUjI0?=
 =?utf-8?B?clVGb0NuSW9MV0FTN3dpbVFsK3J0VXJRMG5aV1pQaFhEMkJvRWlJdHNaVnFz?=
 =?utf-8?B?OWlBaXNYOFRSRWxpRXo3cnl4RTRKWFBhVW5QV2Joa3RxbW40UjlTWG14cWlT?=
 =?utf-8?Q?meoYQlR26cGXiwI7YZkplOsYb?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2023826e-6da9-4207-8a70-08da873812b6
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 07:53:32.9623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /FObfbRoKPmfmcn04nk79CyXzrWRzEe1yOdjtBwFpAf9PzZv76569YIkPmEUBCYHkN7oUf5L01w71qC7sorDRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3167
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 25.08.2022 23:52, Demi Marie Obenour wrote:
> @@ -40,6 +41,38 @@
>  
>  #define efi_data(op)	(op.u.efi_runtime_call)
>  
> +static_assert(XEN_PAGE_SHIFT == EFI_PAGE_SHIFT,
> +              "Mismatch between EFI_PAGE_SHIFT and XEN_PAGE_SHIFT");
> +
> +bool xen_efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *md)
> +{
> +	struct xen_platform_op op = {
> +		.cmd = XENPF_firmware_info,
> +		.u.firmware_info = {
> +			.type = XEN_FW_EFI_INFO,
> +			.index = XEN_FW_EFI_MEM_INFO,
> +			.u.efi_info.mem.addr = phys_addr,
> +			.u.efi_info.mem.size = ((u64)-1ULL) - phys_addr,
> +		}
> +	};
> +	union xenpf_efi_info *info = &op.u.firmware_info.u.efi_info;
> +	int rc;
> +
> +	memset(md, 0, sizeof(*md)); /* initialize md even on failure */
> +	rc = HYPERVISOR_platform_op(&op);
> +	if (rc) {
> +		pr_warn("Could not obtain information on address %llu from Xen: "
> +			"error %d\n", phys_addr, rc);
> +		return false;
> +	}
> +
> +	md->attribute = info->mem.attr;
> +	md->type = info->mem.type;
> +	md->num_pages = info->mem.size >> XEN_PAGE_SHIFT;
> +	md->phys_addr = info->mem.addr;

As indicated in reply to your patch changing XEN_FW_EFI_MEM_INFO in
the hypervisor: While this may fit the ESRT purpose, the address you
return here is not necessarily the start of the region, and hence
this function is not a general Xen replacement for the non-Xen
function. Therefore I think it also shouldn't give the impression of
doing so.

Jan

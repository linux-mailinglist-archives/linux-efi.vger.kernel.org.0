Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CE05F051D
	for <lists+linux-efi@lfdr.de>; Fri, 30 Sep 2022 08:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiI3Goh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 30 Sep 2022 02:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiI3Go2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 30 Sep 2022 02:44:28 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140082.outbound.protection.outlook.com [40.107.14.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0883DC77D2;
        Thu, 29 Sep 2022 23:44:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMhftuYmIpZd2kcU82FdL1vpqKzb+hHWeXh/AJsbK4XyDn3QBsdBqIC/F0x2Voei2EWL7ta9Fc2cUaWLUzySBm4o2HSKO9rL8MtX9fbFgO6lpdW+qXUV2XJqq7gycrlAAV6EwHMCiJiFvUbquICRMgfP9JV7fBe7NPBMjYRCTAnjVewFiR7/1FKgFGHGFLA+XTbDW0fLDRg3RSX7OwZRpwY/mCaM4WSEWoKBHAC6wVJePaPFvAf/knCZJpzNB3fJfQ6gmyEsCyh/tQGNpvnZ4vX8F5oVNoL0p/yT+NjBbwvfus8QG6oeUjpf5sdPILGuyYk2gN8GsHMmbZEoEJrvDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ig5/f9yGkJ9lGAtU8YAhY4+anw7sGzZbBu/lcG43jwk=;
 b=cgHtxCOIMcQ+1xKN/dfS27i4LCeSxos2wF+ome7jtPjd2CiAYKQm9aVX6Tvv6BJqPZBGeNUGRWOIqG2amb1BAmenee2ZNa3CbmiX+rUvunzbJ2eV3eFptTETX4v3xIFBNzZ2r0LmqBwa0cSK7A2oh6oCbhTAl2lqIMpAbnsUPC12uwxS9TZJvshSXdYyzXD7tdEiYxgECf0nxq/KoMfaW24b3GCbYokSeNpHZhJP7Nkg3O7AioVAGhqMSjlkW4/VDB3qfO4zY4bBIKFOGXCgcYDKUK5QFtX8tRSHNYLcKqiNeB8PuKwC5kve2piWWES3oK8VKC/epjPyGgaOd0TCEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ig5/f9yGkJ9lGAtU8YAhY4+anw7sGzZbBu/lcG43jwk=;
 b=YrHo/l8tL+I9+xzdq2f6HTJhx0KMWPTwKNtVJreIA9fAY8IscYwQE7rF7JeYVput+Ck1XQXFqXTDHxZthzFJA/gC8+3IgUnh3AsW1AmtWWq+4CdzLLYWrdx4C2DYOJ3qtspZH+seVp8kIqfcL6fORmvo8PlPsZNntHl9fsCXbh1upZlZiHjRm5Lo+ShT7Vs0rT586s91EETfP8q7nLa9chuka6BfEPY5sZCSMPUeiL2ii6sDTEeX+K+QJWZ6tJ6cIAqmQj6pLaaU3gj2TQR+JBxcRLQ9/3maNggQWK/upskHiy4ieB9kbFSsc8CbaN7n1b04UIIiATlU/0yUDGXQNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by PA4PR04MB7599.eurprd04.prod.outlook.com (2603:10a6:102:ea::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 06:44:22 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::2459:15ae:e6cb:218a]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::2459:15ae:e6cb:218a%7]) with mapi id 15.20.5676.023; Fri, 30 Sep 2022
 06:44:22 +0000
Message-ID: <282a225d-8782-0321-6f0e-19dd4510dc42@suse.com>
Date:   Fri, 30 Sep 2022 08:44:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 1/2] Avoid using EFI tables Xen may have clobbered
Content-Language: en-US
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>
References: <cover.1664298147.git.demi@invisiblethingslab.com>
 <f3b624e99adfdbbfc1976a60a73a6b5950e1840d.1664298147.git.demi@invisiblethingslab.com>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <f3b624e99adfdbbfc1976a60a73a6b5950e1840d.1664298147.git.demi@invisiblethingslab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::14) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6560:EE_|PA4PR04MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c3e36ac-11b0-44f5-5e38-08daa2af3571
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fdiBvFBMCuhOYcClgqCAmmK5Oj3HkE72rjo5wKVmRpr40GAPp/yuhJpEYWyJUMht+ZJ/1iKcNiDCj8LFeJYFAwvMuXX8/Qm7bQ2gHb4VaWMLdspf6PldtVn+f8hJAdPdD11hYvevZbzBa0oiusWEa4xrRSXkZ8U99P35WGGynW/GsWWOjzhfqyU4vfBPBia7iqg6mMSZGwQNGzPx9QJiZHaVAEOgQMuKSyXddjqYHxfNVJJBBGaMUz2KgzxJQWj2z+INzpMlwZHNEu1Pn67HjxGu0sEIRhwwzijFHdVgGnh7M23AWluYBXtKKQ8tlUWiV7loewSIplTvTTlmamL6b1CJpq+Wqn4cybI6lyf/oiPFLtaMhzy/dYFdkXzyTxOqHc6d3rlfFKLc/p7II0vxAL5xU2ZwFMJOEaHjCFgyjeutXvhAzzDqA+/A2UJqDpUR4fAmekO5kDF1vky82Ta1ntQLagfIJS4vxp3Xghgbt033l8gBVrBhjM3quttfO5BFsaBe/jPsKL08eXtm2psEAoEx8P9wsjJ4WHtVX4j4sk+a3mDEaEyTcW8nJPBzI+VoWjkXC6aro9991OrwrZ3KPzu9Oq6ta4LYAhM+pGiNGW+Jtkx+zJ2mbs8rarLGel9Xsc9DeIjutvr5WMgA7DZMH3DXnsFknH97PM+Q7EhjWmvbgsKeu2NtnOsYITpl3xQqW4jM8TK0WZWknEjit8d6lM6XVyRQP+CsjwWyMy0Z4P831wv5/8MFj7nMuCk2dTuILn29KePYpHDoR7rTVPl3+5fzi7bMIx98pGvhEPnzJOk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199015)(31686004)(2906002)(7416002)(26005)(8676002)(6506007)(41300700001)(36756003)(4326008)(38100700002)(86362001)(31696002)(2616005)(186003)(6486002)(316002)(54906003)(6916009)(478600001)(53546011)(5660300002)(6512007)(66476007)(8936002)(66946007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjFpZGhHWFFudDI5TnZUdmJ6RkdPSm1FcGFxc2tZVWg4dE1XdEtVZmpFT3Vq?=
 =?utf-8?B?Q1J3czVNZWZUWG9hQmVKSFBQZWY2Nm9xdC9ZVWFzQ1lvMWxrWHg5YWtrTHhl?=
 =?utf-8?B?S01ya1RCNTVOYk1xN1NiM3hzNWZRN0twUzhHdzFUUHp6MExBd0s0bkRjdVhs?=
 =?utf-8?B?OExvRjROekFXOEtUUnZraVJsQWg2Nmw0bVB3Z2syMUcwbS9FSnVaenpvWWNh?=
 =?utf-8?B?UXJFbWJzLzE5ZVdQUHI4SGZvV20xV0sveE5JK2lueTFmUGhEUlB2NDJVWlVm?=
 =?utf-8?B?dkk0M3dsR2ttT0JEaHlYSFFzL1Q0a01scEF4TE9EMVdLTXJaTU9kM2tET2VB?=
 =?utf-8?B?TTVOMmJrdHNJUzdzOGwwTDBQVUZMYTJwZWRFZEZ1b2FVWk56N21oNUZqcFNz?=
 =?utf-8?B?eEdIbzBibEJtRkxKanVYWGtnZjNoM29sMC9hV0hXbC9wbEJTTStqbTM2MFRT?=
 =?utf-8?B?YTQyREhpcnEwVlllRWZBTWM2UmZ2Vm13czdhL1o0S1lpVnVwS1hUSnc4TVpB?=
 =?utf-8?B?ZkRzcUhnVngrVXB1a1hyOE1pdUQ2REtyT3Z1QUxEVDdmcGdGbEJveGh5Q3Z4?=
 =?utf-8?B?ZnZGMDU4WGFjYWQ0Z3BVRXhmMDdkbmx0WkxKVGhaMkVxYXNSOENOVWdRYkU5?=
 =?utf-8?B?a3pYeERvQ2MwNjBRcnZiU3JiWkVwQXR6UjIwS2pGYjM5Z3VDSVpDNmh1WStY?=
 =?utf-8?B?T3A1WWo3Z0xlQ0hSeGc1NjJFZmkzMUM5cUdUbkZReitmQjZnSS9XNlpNSDNl?=
 =?utf-8?B?UEsrTmtuU3Y1WGJZUTFEeW96RGN3VUpOSkQwWFJUeVQyNnc5Z2NpcS9pVU14?=
 =?utf-8?B?Z29oTC8yWUpnUXF3Ykl3KzhQSkk3SWZnaHZJdmF5Mld2NUJwdGZwejNIRnE1?=
 =?utf-8?B?ZkMvR1FDamg5amZCMUpkcGNxaW5VZTl1ZlpkTW5haGhIaFVGcTMvZlJnSTBP?=
 =?utf-8?B?Z01FZnR0dEl6Z0l2aFJYdkNsUTNYSGhrMTc5ZTNRSnRkS2JtdXNxWkZORDI1?=
 =?utf-8?B?ZjN3Y3NFWk9CL2VZUHlhdFdLaWJpK3VQeTdyeTNrcDdFSEppMkhJNVZuK3hL?=
 =?utf-8?B?Tnc0K3BReGxzYjREUWZFbVhkTU9TYnUzeXF0Zjd6SndWZ0RyNjBZSkVpandy?=
 =?utf-8?B?RU5yZ0txMTkrOVF1WmFpWEo4TG9sNkl0b0M0TkNYTHVqTkhkelQrTzNDZUVI?=
 =?utf-8?B?VlFraThQTm9MWVEwa3V0ZmQ5VGN2TklPNXRIb3l6RVQ4RXlyRkVRYTVPcnFP?=
 =?utf-8?B?djlhSWJlTE5FWjhob0YyUFU5V1hNeVpqOWNYdTIzSmVZZkZpZVpaMEplcXNW?=
 =?utf-8?B?RjVUN0dUZWtIbTRXSzc5TVBZYlV4TkRBL2JCNGpEZTVwTHZhTVJnRng5TkFt?=
 =?utf-8?B?ZEpWQWF4aG1uV2k0ZVFsdEpVUWlqc3Z0aHJxZ0R0K1hrcmlFVXFYUzN6VkVX?=
 =?utf-8?B?Z0dscWpCSFBUdWpDSUF5aC9RbmxqK2xXVEgzc2hjdGo5ZG5mUFFBbXJzWG5q?=
 =?utf-8?B?RFZ5Y3dWZlVoMDhPREc0L2FHZEpLTi84U1JnWFZkOFdPNUF4MGgvQktQQy9q?=
 =?utf-8?B?K29qbkRXVWx1c1J5cUpncDJVNDdseHpUZm5LaTNPTW44S1JXZXRDMzJra1Zy?=
 =?utf-8?B?UC9sUEIyTXZualpUOWFRN3RjM2VEWXh4dDZtNmJ5U2oyU25qYzUyZjNuRFRu?=
 =?utf-8?B?TUVPMklldlh4d0pJTDlYQlpYbFpsNU9ULzJCcTFvME9IL3JxSUc4ZXRjckpa?=
 =?utf-8?B?aldnUnlNOEYzS2NXajRJYjJFZzVqYUkxdjRGc3ppM0VWZHZGa21EbzRHZk5R?=
 =?utf-8?B?RExRemUxUFRtVU5TMGlabEIyYm1lV3pzYlBuK3hDUW5Ka0pSUzBHV0hQU3lz?=
 =?utf-8?B?RGxkL05VRzNwNXROU0tycVk1WE9oVTdaV1RwcDBxZjhINlNkazhTU2trbTBh?=
 =?utf-8?B?R2VZdUZuaFkyeE0zS2dJVC9wV25tdGZ5WmJhb0VRTFVidnVYQnNkSHBCV0FK?=
 =?utf-8?B?SlpJbG5HMzkzcEpmdFZVbHNubUtyUFA4Q1hZTjFLM3R6R1VMaTBlTGQ1Szdl?=
 =?utf-8?B?aG9BWXlBVHdUeU1iMGVqaVhMRW9KelkvY1RiVGhqTFp5Z1hEdlRDTWpHSDd4?=
 =?utf-8?Q?As/S/jjNhCRkUFvM/3TGdo8VH?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3e36ac-11b0-44f5-5e38-08daa2af3571
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 06:44:22.7351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JK4TLx9Mlmq6iDe2pHvLEl9vzDDLN3esgfaVZQbkls7E7M10lZx7mGfuwsKPfLmpx+4Has+jda+B3AY0/LG1SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7599
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 30.09.2022 01:02, Demi Marie Obenour wrote:
> Memory of type EFI_CONVENTIONAL_MEMORY, EFI_LOADER_CODE, EFI_LOADER_DATA,
> EFI_BOOT_SERVICES_CODE, and EFI_BOOT_SERVICES_DATA may be clobbered by
> Xen before Linux gets to start using it.  Therefore, Linux under Xen
> must not use EFI tables from such memory.  Most of the remaining EFI
> memory types are not suitable for EFI tables, leaving only
> EFI_ACPI_RECLAIM_MEMORY, EFI_RUNTIME_SERVICES_DATA, and
> EFI_RUNTIME_SERVICES_CODE.  When running under Xen, Linux should only
> use tables that are located in one of these types of memory.
> 
> This patch ensures this, and also adds a function
> (xen_config_table_memory_region_max()) that will be used later to
> replace the usage of the EFI memory map in esrt.c when running under
> Xen.  This function can also be used in mokvar-table.c and efi-bgrt.c,
> but I have not implemented this.
> 
> Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>

In Xen we don't clobber EfiBootServices{Code,Data} when xen.efi was passed
"-mapbs". Should we perhaps extend the interface such that Dom0 can then
also use tables located in such regions, perhaps by faking
EFI_MEMORY_RUNTIME in the attributes returned by XEN_FW_EFI_MEM_INFO?

Jan

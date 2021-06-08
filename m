Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2329C39FB6A
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jun 2021 17:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbhFHQA3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Jun 2021 12:00:29 -0400
Received: from mail-co1nam11on2045.outbound.protection.outlook.com ([40.107.220.45]:14273
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233032AbhFHQA0 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 8 Jun 2021 12:00:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0KCVznv2Ud8DBqzecguon5zazPnUqx2fYDvPSF9Uv87OVyYwWfkSvcV3BY6XJddzsJUxW+4vHbaxM1PXD58zRN1AaKyMRLebpWAlOyy5reSkygxk76zkG/67KQx5ESqrgI3AsIU3EzvQZ/gyoPEZAZjeg21x59zr5h9jPlkw7UGj129mCEEqg8uWdR3ocoRjTsAybb8e5JAImLbnw7HuOcCmVRIjtdRMUoLgRIW3qH0qFlyYZT0C+5s0bRYJUkNsEOaVMHpZdBvTcSpt41ovasPZdzuYh1kLlYGC4DVM4zcWaxmZUYp/TG/rLV04OnV3zNjpsq4oxbWH7Mn5hpC/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqIU8YP2Ozl8V14Ar/uHiJzsyKHh5c9/W32711urMBc=;
 b=gHuKWvWa59TfMEEu9U8RVpf2uja+3F2qSh0wnG2uBJzuv8KI2rnQN/fNQ2AynrzZaybQlwByc1ohwLzwEy42trBNzX3q6/BLksE5d6AOmEEZsgrLNlRrxxoxqb1nZFlcuu84ETyfogEsuiy5KbvU2GwxviuCmL5wM5uu03w+V1bdAf5c9y3swN3QP3htZWNvoXQokyFTGfLyrkXiwuCJ9aXfNllieUGzhWK3wB+PrZx8D019NDcnnMqOdj1UiADEUXIOto8pTdABC3i+FoRDUf1f+Mw51Va63tAg96CxTTkW72EiO7hcp89l+pM2OwEID4ma2qiIILoWKCwY6jC7Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqIU8YP2Ozl8V14Ar/uHiJzsyKHh5c9/W32711urMBc=;
 b=xZgs58qxdcTRdvZ2dweJGjqNYNLL3Ngd2UzrQDTpEkXbguqMCsbuULXJ6W6yOw02YKWIGuBNfO66DEs44fFur2nKTY8VE3zt8hG+wXaxudpn+8N4hFduraI3ElY8vDrHsnq9ofJxN4qGYAaRiUk4YX9tzeCmwndPG4aFZMCXtBI=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4559.namprd12.prod.outlook.com (2603:10b6:806:9e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Tue, 8 Jun
 2021 15:58:31 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4219.021; Tue, 8 Jun 2021
 15:58:31 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com
Subject: Re: [PATCH Part1 RFC v3 08/22] x86/compressed: Add helper for
 validating pages in the decompression stage
To:     Borislav Petkov <bp@alien8.de>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-9-brijesh.singh@amd.com> <YL9Qo/8ycWKZGRwt@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <49176b2e-b7d4-b6c7-78ad-1dee66c51d2a@amd.com>
Date:   Tue, 8 Jun 2021 10:58:28 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <YL9Qo/8ycWKZGRwt@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [70.112.153.56]
X-ClientProxiedBy: SN6PR08CA0004.namprd08.prod.outlook.com
 (2603:10b6:805:66::17) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by SN6PR08CA0004.namprd08.prod.outlook.com (2603:10b6:805:66::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Tue, 8 Jun 2021 15:58:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ba1ff9d-6e7f-4854-42aa-08d92a964301
X-MS-TrafficTypeDiagnostic: SA0PR12MB4559:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4559E1498EA7B45FE8106CFEE5379@SA0PR12MB4559.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:198;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bdnczZkc5kg6G+U/vygLd/ix4v2JasSEUxf7eTD2McyhSmijZ8VV7I0+dHH1mcIKLQ3vtnjya8pqE0g06q1alm+X4hgNcmSZKW5lAypfxIl/Ae1kmzHlMivA/jk6ws7Fk/UdRwbFBWx4veXcsi6+0t1MyASJCV9tTaGrmnZNCMoDK4kNv92dTd/8fMQA+CvU0Xaxjirld4UYKRPqgCY45ClP/vC18CTmrcNYDyrM5Dw3zgt3xT4QPyFEFJqtnnVdRUQLZmcIlaXbnK8Z+hV+Jb55lpOAw0qqDzoE6Ibn2lrPHpHDch6Y860YFX5phpkINNoDffbcZdG62VENxtf2gq376AoUdyXzfJWd/eCcAeCL+ZHNZnrgFOZnlm/FNEh8ZR19IJTqnAr8wtLGIaqEkADGPmQCQemnnIdQ9gcSBbaq7RtjRWEm8nsDbb6TpPR7BVqRHU0ZZ0/Q6yPmAXY8xLAOQfiMOvFnuBAvrfytsdlmETrVh5ekwLG/2vT76S2Qm/A4sV3QCy2So5SMD1CJmsq33lIjKOVOjfxu+lhqb+70mFp1tiHejdDmpUME6f/NnI7roy+OgI4PMExu3B6RnYSVBnwHysu4a1tzQH5QdA6bqGHMfvWUm6RS5zKG/wU4rs1ZxPKuP+rnwDDgbWVLAw9Xsj5R0h/SNtBIaa2jOSl49tglR+fITp5Mg5MEZj7iIHuVpWPShsCuZoUer/Q4oejO7VcD3zJn42vBuIirl2Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(8936002)(26005)(6486002)(38100700002)(6512007)(6506007)(38350700002)(2906002)(558084003)(52116002)(53546011)(5660300002)(54906003)(16526019)(36756003)(66946007)(66476007)(66556008)(186003)(6916009)(7416002)(4326008)(31686004)(44832011)(31696002)(2616005)(86362001)(956004)(8676002)(478600001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VU9CVXp3M0NBZUwwbzhQYmtNKzhzSjFjUDNOQytaUHB0WDdtZThKNnoyM3V2?=
 =?utf-8?B?cHlIanNnSys0Uk11Z2dCT2FJUWpUNDRMdXNxTGdGbFRrb0dOVWFxWUVHeFpu?=
 =?utf-8?B?cjNReE1qc2NDMFFEa2FaS2oyQmExR0J0VUYzNFpSaVg0REFvcE9DNkJRUTRH?=
 =?utf-8?B?WlA3Y1dCWVhFb2dQMmxtVzErUCszT3hIMEEzaTEzU3RydFF5M05OVThjd3FS?=
 =?utf-8?B?QUorZlR4MnZJK0Y0QlU2b2tXYy9yRGVUaXdURlBpYi82YXFSYnBlUEQ2SU13?=
 =?utf-8?B?V1R1RXl4azVwK2ZFVjJFaWpxeDE3SW5yZHp3WmZPYWVqS09vcjVUcllJSmt4?=
 =?utf-8?B?NmpKTmRtU3ZwN0tOOG5jMGd1ODNyQXFsWkdNS2RFeHZMdytleVdUdHdpd25u?=
 =?utf-8?B?STFad3FFcks4dWpqNTU0T3AvT1U5YjVEd2hReWFmYkRCeU9BZGc0REk5Vm1t?=
 =?utf-8?B?ekZuZkVmYzNubUI5VDBOVzFjbnJqRllLcmVzOUJXL2N5OEFNWnJ2bFZxS2pG?=
 =?utf-8?B?ZzIrOG8rZ0tnSUhxaUdwcDJ6clh4WHQwYVlJbFFMc3FYdHk3UE5NMXB1Yjh1?=
 =?utf-8?B?N09ZZHprZGJGU0tiMGNIMTU3MVpzUFhjb2xPK09jNzczR1hLZ01YZHlVbmVM?=
 =?utf-8?B?aUJ3OGZZc1hnTmNJeGZSMGF6Z2lPSGZmODMvQnJGMWIvY09wODd4YWxuUk9m?=
 =?utf-8?B?Z2hZUXpmaFR3bDJVSElJbStHMG12QmFaNGhrbkVYV1NFcUdNbFMrUXF3c1Uv?=
 =?utf-8?B?M0pUWS9zemtoLzRpdE5zbnRYcEs1ZTdSMXg1MzE0MksvVUVUWGxFZjVqMitN?=
 =?utf-8?B?YUxleUtPS3EzVTQ4Q0wrNEJTWm9GU29YUlZRRkRLR0Z4NEJIeDI1bzV2VjZv?=
 =?utf-8?B?ejdseG9jRUF0d2kwNjVVbFBERmNlMWRPMlY5K0N1eHNHMnRjOEF6R0Z2TmZv?=
 =?utf-8?B?WFdqQSt3bWxNVkRkdzdraGNLNEphTHY4WHg1TWxsZTNsT3ZZTXZXYWk3VFM4?=
 =?utf-8?B?dko3emROYndrUDI5c2RaRUFYQkRldkYrNWkybnRycHh3S1NhdElaRlJuSjBE?=
 =?utf-8?B?VXVEZTFxTUh0WmJzR25TMG9iRGRaT2JNMGlnSHhMMmt5SVBPdDdXS1VjZ3VX?=
 =?utf-8?B?NWIwci82MVY4MEhjZzQrdlhFVktDdzc2SjdzYjIwbWthY1R0c3hINVUwaElk?=
 =?utf-8?B?eXB0VTVLaEVhNHpKZ2h4VEhqc1ZPeE8rcTRrYlNwTXp2RWxod0dmNEg1U0Zt?=
 =?utf-8?B?QndkSjdQRFQrWWppbnE1emNuY2kxN0c4MmRvOHlYRGR6LytqUnZsaXgyeElJ?=
 =?utf-8?B?OEhQUEd3OU12eWI0MHJhMFJqTlJtK1ZUUmZvTXJJMDR3OVh2Zm81eUpDNExs?=
 =?utf-8?B?VlhFTVoybEpIVHhqeEM5eWs5N1pCaStzeFZnQ3ZNcUZVZTBqRDJDY0lOUHpq?=
 =?utf-8?B?RzVDOEJvaXVOcDhmSFc5S3pVd3lQd2VFQ2VnTG5HRzVrSllOWHd2S0lJYml6?=
 =?utf-8?B?TlNtTDJSWDNkSEJab2U5engySDJzcHpxeXNNdTVYaVVxTlh6Nm5BMnhFbXRs?=
 =?utf-8?B?UTcxd0JkQjROTmNvM3JrazQxNmxZRjhGZnQ2Q1B3eEtRcnlYckpZNmlHNHdT?=
 =?utf-8?B?S2cxOEEzMkdzWWxsYnlmd1QrMWpLY1k1L2ZYaVQ4R2g0cjBVakFzU2JYZzRs?=
 =?utf-8?B?dWtIaHJRWjBQY0JoRlR1TEwrVUFWRVlpeit2dDRHeGxua0d1eEp0YkNRbnpV?=
 =?utf-8?Q?+3aGOxITaMV6icYGRrs6GgwJzK9NEdUrJNBLTXt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba1ff9d-6e7f-4854-42aa-08d92a964301
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 15:58:30.9551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1AZv3uSmMxuOIsalEvjnhJuKaGx44u0vDh0VaM9ce8fiJpmH1MolwajWNl94jmaGYLhwtYJY9ieNiOPcc95qYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4559
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 6/8/21 6:12 AM, Borislav Petkov wrote:
>
> You don't even need that label, diff ontop:

I will merge your diff ontop. Thanks



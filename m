Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BEB731FA0
	for <lists+linux-efi@lfdr.de>; Thu, 15 Jun 2023 20:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbjFOSBh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 15 Jun 2023 14:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234906AbjFOSBe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 15 Jun 2023 14:01:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201C0294A;
        Thu, 15 Jun 2023 11:01:28 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35FGJfKh020981;
        Thu, 15 Jun 2023 18:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Cx+AglUz4EiwLL672TyWbN8szaImaJKBS7TzVI4dZ+Y=;
 b=TBb57vbjCeSASEtk5bwN9WIsXya/s0Mk5oLxpHbzZ1OpOD2s0pFbMmOY+Y1UcLph+3Jh
 SWdcglYIS5lFAzwfrWV3T7bMgSaIt4t+qWUTC7QyQlP05nr5pOamfGr+AAIkCtzCPtOL
 LcbeJIswxh3Z0u9IIEHExSYrpJ6o5fFGIsf+sYOTCgkWtws/trpcV4OJvsv0gVXw0G9W
 me6g8SNorjKPHugRB4WhEir8jx5lqQ2tjmGyoE74qKf6dLUTeZjiKwVuTbketOnyoPg3
 rEibLcmfEq4n1wicomBDZHL6/WuDdFR7aIJ7tv9MQIZkwXyPuMgqOR83/JhCet+fll4I 0A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4hqutp6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 18:00:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35FGWFjm033589;
        Thu, 15 Jun 2023 18:00:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm790cc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 18:00:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSJKRj+1Bg9aeoA8TcbuM4W7SxuPiplkFCWX3nGZy3o/vOTwLJASdrSOCUauBTxQlJ2FCAGJArvQk03BwPldjeWaU6mk+/T7Pyepi84XZhuL+27p6lIl/Xxz5/2KEkxM5lC4KdMWAJ2QNoSWa+SzpeiF+O0bmW5o4LdGLPnqI1v6Pk7zVz0IXH2OyvvSVXrq77HzZX1dQ1P29f7cLq10wCHOeqr9EKt16Q21/I00j+VguB4agUHtC1x2ioiJHiZNZj3AF/+hru3jjuHUxCIqGUfZRn59EhivC2V3SosTl0RQPl6NJhngRz08jUjADrGXjpMd7VoOBRHn+tYC7c4T7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cx+AglUz4EiwLL672TyWbN8szaImaJKBS7TzVI4dZ+Y=;
 b=fig/xBGE+Ui9rJHkaA8F+phc9OkccRaJPhvPmmcq7la7/ZtTQUMeu4qVAxKd/FzVZVu6avNF66DlxXwpXGsdYkhOWd29gWYljeuIK7JPvAfxf+owEyrP2OyAFuvcnF9kqLFoCk8D0OeG1mdov9FC+5rKsDmdz3Vq8hhBATlN4ImBsHOHUuXgaj9p9CVM7++Fg+jl5l5pXv73JxvorZf8ZLyrFyfZUJjdiyDpY4mav85uOU4RswylMxRpK8l0dj/jEonkqFVvNoGoM0XFeob4/47Qt1DcUuUWBnJVrkGq0EcAw3A9OkQQ0fhDhwo8Sj4bj3l9fe3UQxAF53Cluu8bmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cx+AglUz4EiwLL672TyWbN8szaImaJKBS7TzVI4dZ+Y=;
 b=THuDAJjcR9XUgY2TEqtARuKI1xQr0o5dBW5iBkiswJC4LDy8dyXotLEioqZ4JAxib2qkKYUWGJaY6sriVakM4mnEQ9blR0g0SIYzbGXLNy40Z2j48gZNukf6IlMRftqDLkylhY8GIOtttsxwCG+ApoZT5/HTeVgjU7ldW0WttFk=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BN0PR10MB5094.namprd10.prod.outlook.com (2603:10b6:408:129::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Thu, 15 Jun
 2023 18:00:30 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::773a:ca84:21fe:b3de]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::773a:ca84:21fe:b3de%5]) with mapi id 15.20.6500.025; Thu, 15 Jun 2023
 18:00:30 +0000
Message-ID: <3c28500f-1284-eee2-c63a-590c280b675c@oracle.com>
Date:   Thu, 15 Jun 2023 14:00:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 07/14] x86: Secure Launch kernel early boot stub
Content-Language: en-US
To:     Matthew Garrett <mjg59@srcf.ucam.org>,
        "Daniel P. Smith" <dpsmith@apertussolutions.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        ardb@kernel.org, James.Bottomley@hansenpartnership.com,
        luto@amacapital.net, nivedita@alum.mit.edu,
        kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com,
        Ross Philipson <ross.philipson@oracle.com>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-8-ross.philipson@oracle.com>
 <20230512112623.GE14461@srcf.ucam.org>
 <98decbe9-846a-6d36-aa7a-f906a19fa6cf@oracle.com>
 <7ff17d2b-7030-fbbd-c495-b43583e3f9e7@apertussolutions.com>
 <20230516014549.GB5403@srcf.ucam.org>
From:   Ross Philipson <ross.philipson@oracle.com>
In-Reply-To: <20230516014549.GB5403@srcf.ucam.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0547.namprd03.prod.outlook.com
 (2603:10b6:408:138::12) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|BN0PR10MB5094:EE_
X-MS-Office365-Filtering-Correlation-Id: c8675f2a-21a5-475b-6711-08db6dca681a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bfbpluL9fCWE6d8Cd2Fpv9/7EN7TAJcNbKw+iZYBlapuQ3rOQUxkknuYE/GvImG27Ky8g/ruTPgTXonHoyXp5PDGIC8E8uI6m7dfF73eG/uhkG9p8w/U3eO779NOTXO/flgbxbG6yIH0GEEpBTUkDmBBkiHxx6ad4NRHP1paTQ0Bt0pDPbpNbUw/P2M5HniPvUk/mOZzfxw86Pcb4ko3PynIG7nsN/fxIh1msvgZ43o7wboftcjGDQIw9qA3SljqjWZfeFM0si6oDXg7rVYs9rFTrwlBEN5CI4KWbMXjeqEQev3UZqM6PqBQCgYt/MngioEgTgUw/QiQAQ+BXkNGx+ZaU+5PIdRrGV+jiBy5/0pID2YKIZuMaJBK9nwgfzaNy099KIojsOiofDB0PonCQ72Opc9AUgJRyOOT9mSTHJCxQJpw07AYwKFvb94HcYOn4qgv12O/uVjpFOFAknZcWP7qGy4dY9PfeLzpYrHS/lyXgSoi6VH66qJU97nIfiQhrziVMaS5+lhQNelMavq79K6TyE2Z9JnieaX5EIPdJnnkS7VlWZRjJhZHKeNPC6ZUx8JsGIxa3fYCcUjF04Cu8fAKHGJR94gxwj8MB6S6yoji43VcH7yV29GXSDZxp2LW3vrxpSDciNAwNuDguam7fA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199021)(31686004)(86362001)(31696002)(8936002)(38100700002)(8676002)(5660300002)(7416002)(316002)(44832011)(41300700001)(4326008)(66556008)(66946007)(66476007)(110136005)(2616005)(53546011)(478600001)(186003)(6512007)(6506007)(36756003)(107886003)(2906002)(6486002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVNIYi9UTEtkZ1R0bk5jTlFUNVQ0cVovOEFnQlBJZzBLMFAxSG40ZGo2VzU5?=
 =?utf-8?B?WmxVelQxekU5RTFYYkRuNEoxSFR4eFkzVGR3Ty9VTVV3K0R5OFlsZlhEY05s?=
 =?utf-8?B?STlzdWR2VVRaUXR6UmlMUFRaSkVUUlBvZ2piaVhBS09sUG5Ga2ZndXN3TC9l?=
 =?utf-8?B?bUlBSDNNbmRsSmt5bFYvemlsSW82QUR4ODQ1OFRnQU4zMzNxWUJudjBSbit3?=
 =?utf-8?B?bUpzMDFHbHJDRUlpVGpUZlJOWm40RGdXNnh2YXNUWEVqV3liK1pMOGx1Ty9F?=
 =?utf-8?B?WXJTQ1h1TEZCTkpHeFFCVHNnRThCRGZIUFhudlZvajhDQmcwelE5Unp5ZDF0?=
 =?utf-8?B?bHdNdnh5NmVmSmhGUFZrdkxxKzVoSFluTURvZFhOaDdkOWpBYmt6czEvUGxJ?=
 =?utf-8?B?N3FaSHVpQmdtTnZmNGQ4T1FpYTVSNUlnK2VxRk53Yk0yVm1Wa25ydDcza0oy?=
 =?utf-8?B?Wm1TQ0R4REVqb3pSSnZSNGtGT0Eyc1dlV3U1SWVweFZJVmxiN0Z6S1B0U2NK?=
 =?utf-8?B?YVh0SnVESW93bXJieTNUYkdzRG8weTNSREVJa3V6SUxxWS9PQkNjZ29hRzFE?=
 =?utf-8?B?YU5WaVd0aHdyLzVFVHBCQVVoSUROQ0ptYTE2Vkt0eXB3bXJNajVkSFRLbjRl?=
 =?utf-8?B?Z0FSNTRBanFIUDNOTFFjcUNNOU9Venc2a2hONk5HQjhDaDVCTHFZaklvK2I5?=
 =?utf-8?B?bTIyK2NLbHJIbWtaK2E0bXgxQ1BLaTE2NmZHK3VuNVJ5c2hoNFVZdmFITW12?=
 =?utf-8?B?MFVSN3ZyMGJ0ZS81SjFxSzVxeXpiMWRxNzROZExGT3ZXdEd2S2hBcEZSMFUy?=
 =?utf-8?B?aW5KUFRwRE8za0I2cVJZT2xLSU1sSlFoRWFFWXVucFJsbVlaMkhXcHNzblNo?=
 =?utf-8?B?RTE3T21Oa3VZVnZHREgydVRrSTFCVUtObUtRZ0RwM1VUaFFGZEVzQXIrTFA5?=
 =?utf-8?B?UDRZS2Y0NmVmYWp5OXhEekZsK3ZMbXRmb3dYT2Z6WnVSZEhrODV5Wk1HWG1R?=
 =?utf-8?B?NzJxSzk2NjBXQzVqM0xIM29HMXZncjlHazZKbnhCVEE5UTBLYnZpVGE0VS9o?=
 =?utf-8?B?eGQrdVFaVmdLU09PSi9qeUtSWUY5S25YbmZrSDliaW8rV3kyd0V1SzNXZkRl?=
 =?utf-8?B?blZsY3NvVnZ1bTN0U2xrdFE5UnV1Q2RvWE0zVGo0eE1xWXk2MVVZSDFjWWho?=
 =?utf-8?B?TVhmUXh4aG5Va0k5dHk1Sy9QanM1QlBqY040RnFjV2ZVcGw0VTcvQnZFRHY0?=
 =?utf-8?B?U01sM29xVDF6eDJzODE3VkRpQnhiSlM1SU8yVTRtbjRva1BQZ1dZUkVGcU80?=
 =?utf-8?B?QUtZRUxadWl4ekkya0lPUlU4WTZ5YnppL3pEdTVTMHFlSzVTcmF6cm4reEpT?=
 =?utf-8?B?WGdtQXBTM1N1K2JXR3dhMnd1eXJUMXlkMnE2VTltamZJUUpMbXZWYzZVMmZ2?=
 =?utf-8?B?Q3JDaDBuNTNRc2M5U3dMekYxTEhqTE84RFpsQS9VLzhoa25RK1VLSXpReTBZ?=
 =?utf-8?B?N2NYZWcwVzlRMGhiM3JHcHM0WXl6aXNYSklYNnp5YmV3MFN6SEVaWkd4Sjdo?=
 =?utf-8?B?dDdNWFNMM0dEWkQzYXNIclliOVBkak15RitTNU1jdlErdDU1VWZxNWNaUkZJ?=
 =?utf-8?B?dGRBM2pRdGt4VTVwYjJlNGxzZUwzRjd3ZXFPOEhxL3hnSTd0VnZobXcrc1ly?=
 =?utf-8?B?eTVsOE9GTzh6VFRUOE5VcFkvK2N3bHZaaWFERUlYSkxxWmVtTVE4M3VrWlpG?=
 =?utf-8?B?bDJpTTd3dFh6akZ0VjNSSUJydFRlNERsZWZ2bTdIL0RCakkzdFkranQ2TFNL?=
 =?utf-8?B?cWkrNmozT3MvdjBhVUprTnJrRGxBdXNvSFZ4YnNsaUtWWHU5bUJkWTR5QVRI?=
 =?utf-8?B?TExkamQvWHBZdUZ2a2pWUUR4YmRVUHVEMFlwYWFaeVQrbGhaVmpKWHRWRjJu?=
 =?utf-8?B?OWJiTWpSaHF6YjF1c2NseGVDekEzaHJENWhSamdCbEhnVXk1S3prWXVwY1dV?=
 =?utf-8?B?K3kvSXhQaUlpd1dqNkxJZWV0eUJVbjR0dHdnR1g5a0lBNE5tWUg4YzhXWlRJ?=
 =?utf-8?B?aThveElHQjdQMDdXUEZYZ2RIOS9NTFpMdkVLS2VBWFRIUU55TlpveGVLUHN3?=
 =?utf-8?B?ZWc0WURTSkJhYy9WK1pJRjg0OWpXRXlYQXJtQVBmM3N6U2pzWk1wMHZuZGxm?=
 =?utf-8?Q?h7Go9GIZs3jypF9kV2vXmtU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dWZ1TlJFeWkwM0R0NkFQUTlxUi9kSWpKSzR0ZEQyOEhYbUdNRTdpNFhIZWl0?=
 =?utf-8?B?WW53eUh3TlBqdmJ3UkNEN1Uyb0FIeFhtOVNDTFJHV1pFTXYwSFQwUUk3M0tq?=
 =?utf-8?B?VU9QcUhFN2hPaXpTYXN5R2puQ2pyZTdobjU0RHJ4UVpWbjMxQk9YSXdzUlRP?=
 =?utf-8?B?VlJHNnZmMlJKYStoMVhLUDhjOFhtN2c4Qjl6N2h1SlloUUFYbXJXVXlvU2NH?=
 =?utf-8?B?bEtNRFdtM00yMndGekh4R2RnbmU3Skd3bERGbGtRU2tZTDA1eFNQV1NSMklX?=
 =?utf-8?B?NmxCTTFwaGlsbThoczFVcFQrbzlLeFZzZ2FuSTdYMmpUano0NEErTkJ1bTQ0?=
 =?utf-8?B?cDF6NFMwKzdVTFcwZWI5blZobmFtcFN1cUVvS0xvaU9uTkJWbUtXV0ozclpZ?=
 =?utf-8?B?bTkwZ0pRSG5CN2VKMTJScFlqK3U4a25vTU55SVNkcXc1akYzMUdaYlgvQkxH?=
 =?utf-8?B?dENGZnI1V2Z5ak96UWpXaFRDZlpLbGVhUjZSakJyejhaUGxsSDkyMnB2Vnc1?=
 =?utf-8?B?S1FkTnp4ckc5YmRjS1FBeTZHanlSck10WnRHWFV4WEtFZ3FvSFBYcWJjNGx5?=
 =?utf-8?B?SXA4UmF3ekZJa2ZUbTVOTjJZWkN5S2FvSm9jaGpKTmI4Um5vNEg0d01NdVYx?=
 =?utf-8?B?UUQxV1hINnYwKzlQa1laT01GbnZibzlLeVFsdHpnYjhXTVFRdDVwT0hIMVZB?=
 =?utf-8?B?c3hWWEh2ckNRcGhJNExsT2VFMmhTamg3cjBQMnZUUzFHT0p5WWRveEFsc2NT?=
 =?utf-8?B?eHI3N2dudHVmQ2VCWHZJeHVMNlp5cmdYWWJ3Qk9PUmtMWnFJZVpBbVZ4aWpJ?=
 =?utf-8?B?b3JZWlppS0tiamdNNkVTNXg2MEk0bDlTS2tidGsvamR0RWhWci9uR3FRR1dT?=
 =?utf-8?B?ZWJvMWxrT3FXcEJKMmp4aWNlcDFYZFIzelBCZE9LRmlnNEtYQzlXcVFPbmJ1?=
 =?utf-8?B?VVRVYm5EYkxrM2VYaFhqV1lXUi9XUUhiSnlrSVNjVEpDdkVPVVdDQnFqZXV5?=
 =?utf-8?B?b0JGVjVWejZxTTcya2x0eFM2VWVHVCtUZ0R3WndMamxybjQva1lpR3BYaVNF?=
 =?utf-8?B?eWFLMXFsMTVnYTlPTmlkSEEvOVlqVWZjSFJRQkkyTEYvOXA5d1FhTC92YStL?=
 =?utf-8?B?ZlpnV0pOdlppZy85aWtlcU9GZDJ0cWRJbWhRVmZ5aFVwMXFlQ1RLUUM1Nmg3?=
 =?utf-8?B?dGZKVWM4RkxIWDlMZkIwbGZyV0s0V2tnVTc1Y3l6d21oYWVJc1pkZ01uQWlN?=
 =?utf-8?B?ckQ2RGk5R0RUb256N2hzMlI3SDd1dk9JSWQzODlwZUcrdnFPVDNFMHpFMTJz?=
 =?utf-8?B?YUtTeHg1c2tuTEQzZVZnMDRya2xSaWtjNEVVOTBQbERVS3FRRHQ3b0llRDlq?=
 =?utf-8?B?VnU1azdJckVwZ0dkMFliTHMxQWF6RWkzekJLa0FISEY3ZFFXSGZNbTJ6clpj?=
 =?utf-8?B?WUNZZm10c0s3ODJ6YmJPUVNXeUE3WEc3SkhkcUtFTERUVG5nVWUrNG8rR3dS?=
 =?utf-8?B?TXowT1RTMnNrY1haeGU1bzY4U3ZTRVJkRTBlQ3VRb3pucHJNVDREYjE2WG1i?=
 =?utf-8?B?eTQ4WWlnRlUrU0FobnN2c2dKbHVXVmFaQk1hNGFIS0JaZWdURzgxWXpBa2NJ?=
 =?utf-8?B?elBudmZ5Z0NXdlJsMm1QY3FKMW10eHlPMVFjSkY5TFhEb3QycHFxKzNMQlVi?=
 =?utf-8?B?NjNIUUFMTlp6QVFFdWVoNTZYeURQWGwwbWhIWERNOTRFZDV1UTZoTGtjaXgv?=
 =?utf-8?Q?GQGiU3WDUvt7VLybAs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8675f2a-21a5-475b-6711-08db6dca681a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 18:00:30.2979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vHv4maYRq1lPq43DT0d9cqC7ivoQMalSGolLsRzckLQGUirLmWIG7JbDau/YTW7tw5S5az2AzYySj83gUf20/8joNrlZmWSN35IaeD65pno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5094
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-15_14,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306150155
X-Proofpoint-ORIG-GUID: C64R6s3QTctcuRF4Hv4qucFr2FGU8AAW
X-Proofpoint-GUID: C64R6s3QTctcuRF4Hv4qucFr2FGU8AAW
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/15/23 21:45, Matthew Garrett wrote:
> On Mon, May 15, 2023 at 09:11:15PM -0400, Daniel P. Smith wrote:
>> On 5/12/23 12:17, Ross Philipson wrote:
>>> This is a good point. At this point it is really something we
>>> overlooked. We will have to revisit this and figure out the best way to
>>> find the final event log depending on how things booted.
>>
>> I believe Ross misunderstood what you were asking for here. There are two
>> reasons this is not possible or desired. The first reason is that on Intel,
>> the DRTM log is not initialized by TrenchBoot code in the preamble. It is
>> only responsible for allocating a buffer and recording the location in the
>> TXT structures. When the SINIT ACM is executed, it will initialize the log
>> and record the measurement that CPU sent directly to the TPM and then the
>> measurements the ACM makes of the environment. If you pointed at the SRTM
>> log, then the ACM would write over existing log, which I don't think you
>> want. Now if you pointed at the tail end of the SRTM log, you would still
>> end up with a second, separate log that just happens to be memory adjacent.
> 
> Ok. I think it would be clearer if either the function names or some
> comments expressly indicated that this refers to the DRTM event log and
> that that's a separate entity from the SRTM one, "event log" on its own
> is likely to cause people to think of the existing log rather than
> associate it with something else.
> 

That can be done, thanks.

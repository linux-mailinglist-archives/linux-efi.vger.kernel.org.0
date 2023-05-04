Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DC06F6E15
	for <lists+linux-efi@lfdr.de>; Thu,  4 May 2023 16:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjEDOvj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 May 2023 10:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjEDOve (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 4 May 2023 10:51:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E862D51;
        Thu,  4 May 2023 07:51:23 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344DbOJO012645;
        Thu, 4 May 2023 14:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=tOrl7bwToPdgkLSml1h7WK2eBjs9z6pHb2lNO+Jym7g=;
 b=Rsk7aoPutY4eoZ5Uhqq/NXNx96a4nuphfnEqEEyJw14ntQwbcQAKSvhvY2rgnVZ79GEa
 RMqL4d7/M0cKBpIpde8W83ar6zDzuoeULkFmnmShmc4YxEyVtae3wtQ6ojGo3DRzUXcm
 nz+1Cay697xGVk64MKD8a8+vw/zRFe6LyjQGOkd3eA2JW3lVzGzHcWlkiRu9AedRLV1f
 O/9erlC5/VjFRqENYOGa1kQyBjNpRlMAaCWWChmMCoVG5e3QC9oOztCEdalf+TaxhF7d
 lpfDDuyy3v8Ye2oG9+ASmrgR5ZGEUwUyT/Jie3eng8Tm95euw03WK51lL5GCs9lU1P3r Pw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8usv1ydf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 14:51:03 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 344EFPUo024884;
        Thu, 4 May 2023 14:51:02 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp8tqxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 14:51:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mc3c7iG8OnedaS5YEvCoIu4Fjd86xDnFVbx4S427Yni7IS3WwYZiys0I/Td0drmnjGI9Evgf9qECF+VVCGhCBCSCwTuLnyxINdtvuCka2J3UtTkPM3E8dcMRIwikktUhNuQYSDgWvdlj3I64+L+g6WwNAEIS3OGsAN+bCU0Y03kozt+75YB2eO3qNUGRi5XAhicA0JgH53xCImeNi7rbcvEoCrrP3GSv1xuEAJ/3TYlPjAbDPm/o1YFciIZVTBvpXxMsAlW6zukTQJpKCLaeC+eDnxICcdlKXGx2K6WrNyBvzpXfMBjzZ7OAT3BwuxZJrXZJGrwsfAWKoKsuWYmd6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOrl7bwToPdgkLSml1h7WK2eBjs9z6pHb2lNO+Jym7g=;
 b=FCazusbSub3HvCIQ1nD3ZrztxT03yCvX97gO0rQIIf4auyMPiRzQZ7hLhVXIeHictcWXt+YGhWuD+IqjW6twsFr1caeASOpF8NbQU0TjIyFR//JUoIRO2aYgg3UqC80m+zXP3udB8uo+KJV//q9D8PL356Bi7dMgAJ0JMJy9rV0q8PGd9u3M9N10K10WUfLzwS8AYg8FHq2upKN8DYnOKoeVSOSIsRmalK0oPiYvKB/JjQLftZ1ywUT0n5onkr40CXnMdvXJmAGiomymj6oNbxrZHnSd/vldgK05qOBGzaTI/1qXywVFI9e7tJMPtAHm/nvM5lF0YI3STLgjXPUXVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOrl7bwToPdgkLSml1h7WK2eBjs9z6pHb2lNO+Jym7g=;
 b=kMiJPFn9H07zMiqsUfmH2TyatXEydMPXbBZy1spt9unZtfOnx/uM9FeKoxWyOfCW0wNMJh1HwzimJAT8da8GhcXfHWMn/AefavXxBxL0y3u9uyjwVKuL7D5HnFsHyQHzzzNylHdSsP4w/xzt6VqQP3AGlw4iu4TZ9MtcNnXILPg=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by PH0PR10MB6982.namprd10.prod.outlook.com (2603:10b6:510:287::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 14:50:58 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a%5]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 14:50:58 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v6 05/14] x86: Secure Launch main header file
Date:   Thu,  4 May 2023 14:50:14 +0000
Message-Id: <20230504145023.835096-6-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230504145023.835096-1-ross.philipson@oracle.com>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0485.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::10) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|PH0PR10MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: 9983a358-5ed3-4961-aff7-08db4caef8c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AaZjOb97yEXGbHCFb/XKjumlRbRLvoYEmchdtH9bXh8Hxp+pQcFS1ewJOsyNDaL7Lc0DCIqmIvD0evSt+Dh9syLfvBC74xnR6ppS6g1Z9fKrFnQGQ6kyOKX4mM/plSHev7Wny/jtp8lgCwIa5wcJ6bonzEzpWiXt3NlS9yfkCBvlSR9mkjaqAdIzGKW4/10xA+a0KWCjU8tHmoLVcICCswr2F/Xg74XNHiHs1pYtNZnXUADtrL+qqUpbAFi1MXFvKyJljjn9lZXmbEpnJcYOe3E6TI7xUTPOEZjWPGKHkrpM2Sdnw3OJvME4G0ebYd1h8Vb4N9R20OimSIdg2Oe/N/ViiGndeGJlxxOFxoyC022Y1OCabNFgbf/jKLFDouQhmfEIAfqMF8cXSjQNX/IZXab4gwS/wE/dkbiOiJwCZId+4lTiecdTOJxcVMExVS2f811jj2oViyV0fgqObom7G1QYB5akMETwEG4p3WmgfAv++MVMep5IkFhx830T3U017dPOsFsq281cfpDE1Pxykf3QmzwgdC4XEl413FOmif3IccvJW14grM3rrPkGxHgh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(36756003)(38100700002)(5660300002)(7416002)(2906002)(44832011)(30864003)(8936002)(316002)(86362001)(4326008)(66556008)(66476007)(66946007)(8676002)(41300700001)(83380400001)(186003)(6512007)(6506007)(1076003)(26005)(6486002)(478600001)(2616005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUl1VDkzLy84SEJhYjZsQnVHdVJVWTRnMmVhdW1LUE1iOWw5akxXcXhaYVB6?=
 =?utf-8?B?K0dCcndRcXVKUFRWUmhXdTFQUVdlWlVFTkN6VHhJeUVYTFlSUUtDbXZIaGRT?=
 =?utf-8?B?MFF4ZVZnQXZoU0ZQRTl3cS8xZXdUUWIxMGVCM29SU2xyNXppMTh6WUdEalhm?=
 =?utf-8?B?alJXd2FoQnpUM3JQUUV4WGhKc292M3h2M09CU09mbkNjbzFEanhOclR2T3o4?=
 =?utf-8?B?WTI1T2ZWU2UxL2tBTStXM3crK09wUHcyaGJiVHZ5NU1NbDNIeU93ZHdyc01S?=
 =?utf-8?B?YkxlaUlGYUtieTVTN2twaXNCL2kzeURnL1oyUmsyZEpxT2xJV0xHMFdRSmxX?=
 =?utf-8?B?anpuZmVTcmdsT2NiaTUzeHltTVlwa3czaVNkSUJGb2NrblBoWTdia1ZFMzAw?=
 =?utf-8?B?dm81RTdxSWQ0dk1ueHpiQ0ZTbHdkTjNGT0ZZQjM5MzRqd3Q0aU5qeHRHeFVQ?=
 =?utf-8?B?Y1NRYXhZNGhHK1d3Qnl6KzFvdktSOTdRUzJHWjQvTXZVMHN1VWJvZStQTGlR?=
 =?utf-8?B?YW8rYVZzSUlvZmpJN1ZIelBGbDZZYnp5MzRtTWtwTWRvdVgyZ21rVVllMlFK?=
 =?utf-8?B?VWsvWEZNQmtKSWhzTmRlMU12N0w2V29HdElKYXlvQXMyU05DQkpOeE1BS2J3?=
 =?utf-8?B?Ti9IZGRLWno1dFVqVzVvckNuTWllVktvYVdBbVpKM3ZKTDBhVEY0NXFPWm1j?=
 =?utf-8?B?c29GalptWTRMY3VzVy9KZFhDUGo1eXFtZ0t6aE8ycE1lVHBWbW1PNW5mVHJE?=
 =?utf-8?B?bGdrOFo0eUdhRy9zZTgwZWp3TnlnbGM1WFNxdE53NEhXTEdoaUpjcGdnN1Nz?=
 =?utf-8?B?dzRJeHlHalNTNTFUOERodkFPcjdIeWFrb1ZMTm5CT0wvS2duN05mWGY5aDhN?=
 =?utf-8?B?S1U5czY5MyttZGswQ3AxNUl2eWQ5QU1nMEpBeFFDTkZ2NTVwMjcvcXluUDd3?=
 =?utf-8?B?ekZib0ltNTlQRkgyaUFOb3NyYlVyb0hhTysyeTNvaWk5cjFmOFVoSFNtZEhL?=
 =?utf-8?B?dHUxb0txU3lwWjB0T3JiZEZWdkQwNk5JYzZSUTEzdFZ6dDIvWVBQamF3TjBI?=
 =?utf-8?B?cWlMRVlORDhzWk81dXdpeTNZMmFOc1BMblNkTXdpeld3NTdOYitLQzNMZ0JU?=
 =?utf-8?B?S3Y2eTl4b1N5OUVMT2xaUmovem92dVE0RzJNc24zODhjTjZOTTBQRXdHT2dz?=
 =?utf-8?B?OUZPTC9XWWdIcTR4QVJOSUp3bzhETSsxWmtiNG43S3dVOFE5NFIySFJvWnJ3?=
 =?utf-8?B?RlJ4R0xUR05wOEpUcTRwaUxyK0FTTmc4OVB5WFNna29OU2MvUmtpMG15L2Vk?=
 =?utf-8?B?WTRrREtMTHZVV0FvVmU2NkgyRlRlOVkzRjFJcEJxbGY4MXdkNTM2ZFlZNU1Q?=
 =?utf-8?B?YWdxT1NUSDRScVpVNXQrU0xqaVRJVThWNE5pb3J4M3ozMGk4dkQ0L1VtQUsv?=
 =?utf-8?B?STJvZGtJcHJPM0VHOEFMTGRYYUFGaC9MZEJuVUpFREVKNGNSUklXNGJjdGhL?=
 =?utf-8?B?OHVIaHZGL002eUJaemU3VkFRdTlhK1ZLS01OVHQ2azRTcE9UVTNKRzNzb0Yy?=
 =?utf-8?B?VHV2UTBtTHArUEhRalZoVTBpRDFOSlJvSWxwTDdiN0VFY25LNlVRWXQxREtF?=
 =?utf-8?B?VUV5clRmZHpHZlFCMDNUSDdyamJTeTkvR1lZREpVSkRmWHI3WEI5RG1XYlk2?=
 =?utf-8?B?ejVBaVNxeWVaRTJBWjJuQlFCMWNNdnpYU2lhQk1VOFNWYjBCbjBvc0UybGoy?=
 =?utf-8?B?WHhSSUJhcG43TnEwdDdEY1RIeFFBVGFjZ2hJQTdydVVjSUZacXdNRVErOTRa?=
 =?utf-8?B?NHBUWWR2N1ptQytnN0lpVWozckttSEZyNnovenMrbC9Qa2VvU21nM0NTeUJa?=
 =?utf-8?B?U2U4aGJReGw1MDJ0MTVETE5QRWhOVkFvaDFpZDZSWXVLbEJteE94bWxBck1p?=
 =?utf-8?B?MGdtOWhaakNBZ2xiSWQ4d29aZ0d2cEdDWnpjS3VGY2lDNXhMMHpVRXhhVXRo?=
 =?utf-8?B?VWNYclNKVW9pVXpQbXFSLzQyeXNycXBRdmgra2ZqYXdpeFhITldEdytXZVJG?=
 =?utf-8?B?cDU4OEdRNFpydFJsRWd5cnY0R28rOFJhejRjTFl2OVErQVJoWkJXZEFRTHJw?=
 =?utf-8?B?QzROL0R3Mlk0UXdlWXg4MzdjVlVYdXRtZUpwVWhic0lzRWw3TnF6T2NOSkhC?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eWZORTZ6YXBpWEtQclhkTDFubGptYkV4MktyajF0UTVqQVZRQTlMUFZZZXNK?=
 =?utf-8?B?T1I5eHZqQVVlN3hhUzYvMG82UlZBNWpiNEtGQzB6cnlVU1phR2ZBNkVoZ3JE?=
 =?utf-8?B?V0ZZeDYxZ1l4VStUS1hva0NxdUt2T0VORmpZaFp0UTEwL29uZitFZ2RIREhB?=
 =?utf-8?B?eXBtZU14a21jM3JyNFBoU2RhTE5yRDRrbEJQcnBObHdRL1l0cVNCejB1cGkr?=
 =?utf-8?B?MWtwUEFUaHdGMmxkVjE1T3JSeC9NbEFvYTdEeE1WbWY1eENST1M3bUowWllJ?=
 =?utf-8?B?R0RXdHVEbG5yaEZhSHJsU0RObmFlYTRrOXdxNityMkRVbXAyNnlLTFdnRXIy?=
 =?utf-8?B?czVBcndtLytYY1hlYVFpMXZhS1ZEMUhFb09HcHNYcThNZ2U1NnBUT2Z5VjNI?=
 =?utf-8?B?NnRFdTZkZHJLYkI4WWNhaG02bmRTbU5Oamg1eVdRR3JWQXZrWSt6Y1A4dmRF?=
 =?utf-8?B?T3cvbWNSRGJjNndZendiL3QvbnpSL05mOEN4UjJFdUhlTDRLS295SUhvbURU?=
 =?utf-8?B?UU9KdWErMURFdDBndWJEcHhzNldENm1VSGF0clVZNGx3TDhSamlzS0NsWHdT?=
 =?utf-8?B?dDRPNUowTG00dG1Zb0xaV2RmdmpYaWQ5ZkUyS3kvelJ1WWlnOVJLL1pDSGxv?=
 =?utf-8?B?dmFPbG4vZi81Zks5aGNETm4xQzhKS0FqV1JvdjdIT0hXNm9ZVzBnMVBDenF1?=
 =?utf-8?B?dTN4YVIvM3psZ3E2bGFYRENnQnBaT3RwL0tKRkJaa3hVV0Niayt6ZW5UUW9r?=
 =?utf-8?B?MmJCb25mNXc2MFMwMW1YaEI1M2hpR2hCUmI3Vm5BUkY0OXdSRnkrazFVVllI?=
 =?utf-8?B?djJqYkg0UVZwSVJxcHdhMXVGcVpLZjcwY3BFVTZyTWxBWjNnVERRQjBQTVk2?=
 =?utf-8?B?cXNnbUJ2cDE0SHVoMkcza0VwVCtZVVoxRWcyQ2JWZVhFckpiRjUvN1lYb3R2?=
 =?utf-8?B?OUpCMWI1RFllelVCU1JXRks1MnE2bnpqL2xIM0NUWEVVa2lrekF3SFFJWEx1?=
 =?utf-8?B?YytRUGgzQnZKV09wbTBEaitpSWJTcmFZSTdjN2NZZ3FrMTVBMUtnN1RrSTRp?=
 =?utf-8?B?Zm1qRis2NWR5UE5yWW1WMGhsdmRkWU9uWGx4NHdIK0hkUEl5N2UwWlNxbU9p?=
 =?utf-8?B?M2o0RE91SE04ZzdjVmdZRWZlcmhKZHdqcXJOS0NRcXpQRGQ0enJseHFjMnAx?=
 =?utf-8?B?UVorS3VncCt1azBZTDkzSE1RMG1DMUNmZ3FlOTBFWGtMaHdDTU1KRk1XVllK?=
 =?utf-8?B?MTB0OHFqMDR6WExqVUszeWRVaTNITU9FSS9UUkN2Wmtoamt5L3pKL3E4VzdU?=
 =?utf-8?B?bFhSb013eDVZMExwQkx4djR1emNGek04dE83UDRabERQVTBTaklvTGFpRVpY?=
 =?utf-8?B?WkRGc1ZPLy9TYXFxQkpTYnhsSU5YT1hqQXUzRmZucndrbHg2WXFBYXozSW8r?=
 =?utf-8?B?bVZtdkhjV2ZES25Wb3Y4a0F2SzVWN1BROEUxekRYSkZrNkRGb0JDSWhWVnVr?=
 =?utf-8?B?ZnlvRDdZZzc5WlpQNEpYOTc2Rmo2Ti9lak9HRXdPa0FNK1ZKN2JldXdxSElo?=
 =?utf-8?B?UkxudDhHblFQM0RldEVJUTJldXc2S1k2akxScVRPQ0xUcDRGMjVodFM4TXUr?=
 =?utf-8?B?RlJxQzNzOGtqSjI3STdSTHZobnBOempmbjdXMHgxREs4Z2RiY1ZxanZkTVNl?=
 =?utf-8?B?WmJMYkhaMkEvQWc1RlF2RTg2ZVZZVDdOWjluTXdOT1NJcWh2NG11Y3RuK0JC?=
 =?utf-8?Q?zOiXMmNO649LtB0DvA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9983a358-5ed3-4961-aff7-08db4caef8c8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 14:50:58.6686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7KU1E2CqnxNWp+GFKEzJTnJk1lRlc4cIalwZooHNYX9aGbXmcSrbY7wZcF41KXS056X6HVFHozhJDhlr6TVyxI/LKiqnjpyjHLQrKSDcp8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6982
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_10,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040122
X-Proofpoint-ORIG-GUID: VyBVz23yu0pOw-Rw8_rFwTjqe0zwJKxP
X-Proofpoint-GUID: VyBVz23yu0pOw-Rw8_rFwTjqe0zwJKxP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Introduce the main Secure Launch header file used in the early SL stub
and the early setup code.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 include/linux/slaunch.h | 513 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 513 insertions(+)
 create mode 100644 include/linux/slaunch.h

diff --git a/include/linux/slaunch.h b/include/linux/slaunch.h
new file mode 100644
index 0000000..a1c3172
--- /dev/null
+++ b/include/linux/slaunch.h
@@ -0,0 +1,513 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Main Secure Launch header file.
+ *
+ * Copyright (c) 2022, Oracle and/or its affiliates.
+ */
+
+#ifndef _LINUX_SLAUNCH_H
+#define _LINUX_SLAUNCH_H
+
+/*
+ * Secure Launch Defined State Flags
+ */
+#define SL_FLAG_ACTIVE		0x00000001
+#define SL_FLAG_ARCH_SKINIT	0x00000002
+#define SL_FLAG_ARCH_TXT	0x00000004
+
+/*
+ * Secure Launch CPU Type
+ */
+#define SL_CPU_AMD	1
+#define SL_CPU_INTEL	2
+
+#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
+
+#define __SL32_CS	0x0008
+#define __SL32_DS	0x0010
+
+/*
+ * Intel Safer Mode Extensions (SMX)
+ *
+ * Intel SMX provides a programming interface to establish a Measured Launched
+ * Environment (MLE). The measurement and protection mechanisms supported by the
+ * capabilities of an Intel Trusted Execution Technology (TXT) platform. SMX is
+ * the processor’s programming interface in an Intel TXT platform.
+ *
+ * See Intel SDM Volume 2 - 6.1 "Safer Mode Extensions Reference"
+ */
+
+/*
+ * SMX GETSEC Leaf Functions
+ */
+#define SMX_X86_GETSEC_SEXIT	5
+#define SMX_X86_GETSEC_SMCTRL	7
+#define SMX_X86_GETSEC_WAKEUP	8
+
+/*
+ * Intel Trusted Execution Technology MMIO Registers Banks
+ */
+#define TXT_PUB_CONFIG_REGS_BASE	0xfed30000
+#define TXT_PRIV_CONFIG_REGS_BASE	0xfed20000
+#define TXT_NR_CONFIG_PAGES     ((TXT_PUB_CONFIG_REGS_BASE - \
+				  TXT_PRIV_CONFIG_REGS_BASE) >> PAGE_SHIFT)
+
+/*
+ * Intel Trusted Execution Technology (TXT) Registers
+ */
+#define TXT_CR_STS			0x0000
+#define TXT_CR_ESTS			0x0008
+#define TXT_CR_ERRORCODE		0x0030
+#define TXT_CR_CMD_RESET		0x0038
+#define TXT_CR_CMD_CLOSE_PRIVATE	0x0048
+#define TXT_CR_DIDVID			0x0110
+#define TXT_CR_VER_EMIF			0x0200
+#define TXT_CR_CMD_UNLOCK_MEM_CONFIG	0x0218
+#define TXT_CR_SINIT_BASE		0x0270
+#define TXT_CR_SINIT_SIZE		0x0278
+#define TXT_CR_MLE_JOIN			0x0290
+#define TXT_CR_HEAP_BASE		0x0300
+#define TXT_CR_HEAP_SIZE		0x0308
+#define TXT_CR_SCRATCHPAD		0x0378
+#define TXT_CR_CMD_OPEN_LOCALITY1	0x0380
+#define TXT_CR_CMD_CLOSE_LOCALITY1	0x0388
+#define TXT_CR_CMD_OPEN_LOCALITY2	0x0390
+#define TXT_CR_CMD_CLOSE_LOCALITY2	0x0398
+#define TXT_CR_CMD_SECRETS		0x08e0
+#define TXT_CR_CMD_NO_SECRETS		0x08e8
+#define TXT_CR_E2STS			0x08f0
+
+/* TXT default register value */
+#define TXT_REGVALUE_ONE		0x1ULL
+
+/* TXTCR_STS status bits */
+#define TXT_SENTER_DONE_STS		(1<<0)
+#define TXT_SEXIT_DONE_STS		(1<<1)
+
+/*
+ * SINIT/MLE Capabilities Field Bit Definitions
+ */
+#define TXT_SINIT_MLE_CAP_WAKE_GETSEC	0
+#define TXT_SINIT_MLE_CAP_WAKE_MONITOR	1
+
+/*
+ * OS/MLE Secure Launch Specific Definitions
+ */
+#define TXT_OS_MLE_STRUCT_VERSION	1
+#define TXT_OS_MLE_MAX_VARIABLE_MTRRS	32
+
+/*
+ * TXT Heap Table Enumeration
+ */
+#define TXT_BIOS_DATA_TABLE		1
+#define TXT_OS_MLE_DATA_TABLE		2
+#define TXT_OS_SINIT_DATA_TABLE		3
+#define TXT_SINIT_MLE_DATA_TABLE	4
+#define TXT_SINIT_TABLE_MAX		TXT_SINIT_MLE_DATA_TABLE
+
+/*
+ * Secure Launch Defined Error Codes used in MLE-initiated TXT resets.
+ *
+ * TXT Specification
+ * Appendix I ACM Error Codes
+ */
+#define SL_ERROR_GENERIC		0xc0008001
+#define SL_ERROR_TPM_INIT		0xc0008002
+#define SL_ERROR_TPM_INVALID_LOG20	0xc0008003
+#define SL_ERROR_TPM_LOGGING_FAILED	0xc0008004
+#define SL_ERROR_REGION_STRADDLE_4GB	0xc0008005
+#define SL_ERROR_TPM_EXTEND		0xc0008006
+#define SL_ERROR_MTRR_INV_VCNT		0xc0008007
+#define SL_ERROR_MTRR_INV_DEF_TYPE	0xc0008008
+#define SL_ERROR_MTRR_INV_BASE		0xc0008009
+#define SL_ERROR_MTRR_INV_MASK		0xc000800a
+#define SL_ERROR_MSR_INV_MISC_EN	0xc000800b
+#define SL_ERROR_INV_AP_INTERRUPT	0xc000800c
+#define SL_ERROR_INTEGER_OVERFLOW	0xc000800d
+#define SL_ERROR_HEAP_WALK		0xc000800e
+#define SL_ERROR_HEAP_MAP		0xc000800f
+#define SL_ERROR_REGION_ABOVE_4GB	0xc0008010
+#define SL_ERROR_HEAP_INVALID_DMAR	0xc0008011
+#define SL_ERROR_HEAP_DMAR_SIZE		0xc0008012
+#define SL_ERROR_HEAP_DMAR_MAP		0xc0008013
+#define SL_ERROR_HI_PMR_BASE		0xc0008014
+#define SL_ERROR_HI_PMR_SIZE		0xc0008015
+#define SL_ERROR_LO_PMR_BASE		0xc0008016
+#define SL_ERROR_LO_PMR_MLE		0xc0008017
+#define SL_ERROR_INITRD_TOO_BIG		0xc0008018
+#define SL_ERROR_HEAP_ZERO_OFFSET	0xc0008019
+#define SL_ERROR_WAKE_BLOCK_TOO_SMALL	0xc000801a
+#define SL_ERROR_MLE_BUFFER_OVERLAP	0xc000801b
+#define SL_ERROR_BUFFER_BEYOND_PMR	0xc000801c
+#define SL_ERROR_OS_SINIT_BAD_VERSION	0xc000801d
+#define SL_ERROR_EVENTLOG_MAP		0xc000801e
+#define SL_ERROR_TPM_NUMBER_ALGS	0xc000801f
+#define SL_ERROR_TPM_UNKNOWN_DIGEST	0xc0008020
+#define SL_ERROR_TPM_INVALID_EVENT	0xc0008021
+#define SL_ERROR_INVALID_SLRT		0xc0008022
+#define SL_ERROR_SLRT_MISSING_ENTRY	0xc0008023
+#define SL_ERROR_SLRT_MAP		0xc0008024
+
+/*
+ * Secure Launch Defined Limits
+ */
+#define TXT_MAX_CPUS		512
+#define TXT_BOOT_STACK_SIZE	24
+
+/*
+ * Secure Launch event log entry type. The TXT specification defines the
+ * base event value as 0x400 for DRTM values.
+ */
+#define TXT_EVTYPE_BASE			0x400
+#define TXT_EVTYPE_SLAUNCH		(TXT_EVTYPE_BASE + 0x102)
+#define TXT_EVTYPE_SLAUNCH_START	(TXT_EVTYPE_BASE + 0x103)
+#define TXT_EVTYPE_SLAUNCH_END		(TXT_EVTYPE_BASE + 0x104)
+
+/*
+ * Measured Launch PCRs
+ */
+#define SL_DEF_DLME_DETAIL_PCR17	17
+#define SL_DEF_DLME_AUTHORITY_PCR18	18
+#define SL_ALT_DLME_AUTHORITY_PCR19	19
+#define SL_ALT_DLME_DETAIL_PCR20	20
+
+/*
+ * MLE scratch area offsets
+ */
+#define SL_SCRATCH_AP_EBX		0
+#define SL_SCRATCH_AP_JMP_OFFSET	4
+#define SL_SCRATCH_AP_PAUSE		8
+
+#ifndef __ASSEMBLY__
+
+#include <linux/io.h>
+#include <linux/tpm.h>
+#include <linux/tpm_eventlog.h>
+
+/*
+ * Secure Launch AP wakeup information fetched in SMP boot code.
+ */
+struct sl_ap_wake_info {
+	u32 ap_wake_block;
+	u32 ap_wake_block_size;
+	u32 ap_jmp_offset;
+};
+
+/*
+ * TXT heap extended data elements.
+ */
+struct txt_heap_ext_data_element {
+	u32 type;
+	u32 size;
+	/* Data */
+} __packed;
+
+#define TXT_HEAP_EXTDATA_TYPE_END			0
+
+struct txt_heap_end_element {
+	u32 type;
+	u32 size;
+} __packed;
+
+#define TXT_HEAP_EXTDATA_TYPE_TPM_EVENT_LOG_PTR		5
+
+struct txt_heap_event_log_element {
+	u64 event_log_phys_addr;
+} __packed;
+
+#define TXT_HEAP_EXTDATA_TYPE_EVENT_LOG_POINTER2_1	8
+
+struct txt_heap_event_log_pointer2_1_element {
+	u64 phys_addr;
+	u32 allocated_event_container_size;
+	u32 first_record_offset;
+	u32 next_record_offset;
+} __packed;
+
+/*
+ * Secure Launch defined OS/MLE TXT Heap table
+ */
+struct txt_os_mle_data {
+	u32 version;
+	u32 boot_params_addr;
+	u64 slrt;
+	u64 txt_info;
+	u32 ap_wake_block;
+	u32 ap_wake_block_size;
+	u8 mle_scratch[64];
+} __packed;
+
+/*
+ * TXT specification defined BIOS data TXT Heap table
+ */
+struct txt_bios_data {
+	u32 version; /* Currently 5 for TPM 1.2 and 6 for TPM 2.0 */
+	u32 bios_sinit_size;
+	u64 reserved1;
+	u64 reserved2;
+	u32 num_logical_procs;
+	/* Versions >= 5 with updates in version 6 */
+	u32 sinit_flags;
+	u32 mle_flags;
+	/* Versions >= 4 */
+	/* Ext Data Elements */
+} __packed;
+
+/*
+ * TXT specification defined OS/SINIT TXT Heap table
+ */
+struct txt_os_sinit_data {
+	u32 version; /* Currently 6 for TPM 1.2 and 7 for TPM 2.0 */
+	u32 flags;
+	u64 mle_ptab;
+	u64 mle_size;
+	u64 mle_hdr_base;
+	u64 vtd_pmr_lo_base;
+	u64 vtd_pmr_lo_size;
+	u64 vtd_pmr_hi_base;
+	u64 vtd_pmr_hi_size;
+	u64 lcp_po_base;
+	u64 lcp_po_size;
+	u32 capabilities;
+	/* Version = 5 */
+	u64 efi_rsdt_ptr;
+	/* Versions >= 6 */
+	/* Ext Data Elements */
+} __packed;
+
+/*
+ * TXT specification defined SINIT/MLE TXT Heap table
+ */
+struct txt_sinit_mle_data {
+	u32 version;             /* Current values are 6 through 9 */
+	/* Versions <= 8 */
+	u8 bios_acm_id[20];
+	u32 edx_senter_flags;
+	u64 mseg_valid;
+	u8 sinit_hash[20];
+	u8 mle_hash[20];
+	u8 stm_hash[20];
+	u8 lcp_policy_hash[20];
+	u32 lcp_policy_control;
+	/* Versions >= 7 */
+	u32 rlp_wakeup_addr;
+	u32 reserved;
+	u32 num_of_sinit_mdrs;
+	u32 sinit_mdrs_table_offset;
+	u32 sinit_vtd_dmar_table_size;
+	u32 sinit_vtd_dmar_table_offset;
+	/* Versions >= 8 */
+	u32 processor_scrtm_status;
+	/* Versions >= 9 */
+	/* Ext Data Elements */
+} __packed;
+
+/*
+ * TXT data reporting structure for memory types
+ */
+struct txt_sinit_memory_descriptor_record {
+	u64 address;
+	u64 length;
+	u8 type;
+	u8 reserved[7];
+} __packed;
+
+/*
+ * TXT data structure used by a responsive local processor (RLP) to start
+ * execution in response to a GETSEC[WAKEUP].
+ */
+struct smx_rlp_mle_join {
+	u32 rlp_gdt_limit;
+	u32 rlp_gdt_base;
+	u32 rlp_seg_sel;     /* cs (ds, es, ss are seg_sel+8) */
+	u32 rlp_entry_point; /* phys addr */
+} __packed;
+
+/*
+ * TPM event log structures defined in both the TXT specification and
+ * the TCG documentation.
+ */
+#define TPM12_EVTLOG_SIGNATURE "TXT Event Container"
+
+struct tpm12_event_log_header {
+	char signature[20];
+	char reserved[12];
+	u8 container_ver_major;
+	u8 container_ver_minor;
+	u8 pcr_event_ver_major;
+	u8 pcr_event_ver_minor;
+	u32 container_size;
+	u32 pcr_events_offset;
+	u32 next_event_offset;
+	/* PCREvents[] */
+} __packed;
+
+/*
+ * Functions to extract data from the Intel TXT Heap Memory. The layout
+ * of the heap is as follows:
+ *  +----------------------------+
+ *  | Size Bios Data table (u64) |
+ *  +----------------------------+
+ *  | Bios Data table            |
+ *  +----------------------------+
+ *  | Size OS MLE table (u64)    |
+ *  +----------------------------+
+ *  | OS MLE table               |
+ *  +--------------------------- +
+ *  | Size OS SINIT table (u64)  |
+ *  +----------------------------+
+ *  | OS SINIT table             |
+ *  +----------------------------+
+ *  | Size SINIT MLE table (u64) |
+ *  +----------------------------+
+ *  | SINIT MLE table            |
+ *  +----------------------------+
+ *
+ *  NOTE: the table size fields include the 8 byte size field itself.
+ */
+static inline u64 txt_bios_data_size(void *heap)
+{
+	return *((u64 *)heap);
+}
+
+static inline void *txt_bios_data_start(void *heap)
+{
+	return heap + sizeof(u64);
+}
+
+static inline u64 txt_os_mle_data_size(void *heap)
+{
+	return *((u64 *)(heap + txt_bios_data_size(heap)));
+}
+
+static inline void *txt_os_mle_data_start(void *heap)
+{
+	return heap + txt_bios_data_size(heap) + sizeof(u64);
+}
+
+static inline u64 txt_os_sinit_data_size(void *heap)
+{
+	return *((u64 *)(heap + txt_bios_data_size(heap) +
+			txt_os_mle_data_size(heap)));
+}
+
+static inline void *txt_os_sinit_data_start(void *heap)
+{
+	return heap + txt_bios_data_size(heap) +
+		txt_os_mle_data_size(heap) + sizeof(u64);
+}
+
+static inline u64 txt_sinit_mle_data_size(void *heap)
+{
+	return *((u64 *)(heap + txt_bios_data_size(heap) +
+			txt_os_mle_data_size(heap) +
+			txt_os_sinit_data_size(heap)));
+}
+
+static inline void *txt_sinit_mle_data_start(void *heap)
+{
+	return heap + txt_bios_data_size(heap) +
+		txt_os_mle_data_size(heap) +
+		txt_os_sinit_data_size(heap) + sizeof(u64);
+}
+
+/*
+ * TPM event logging functions.
+ */
+static inline struct txt_heap_event_log_pointer2_1_element*
+tpm20_find_log2_1_element(struct txt_os_sinit_data *os_sinit_data)
+{
+	struct txt_heap_ext_data_element *ext_elem;
+
+	/* The extended element array as at the end of this table */
+	ext_elem = (struct txt_heap_ext_data_element *)
+		((u8 *)os_sinit_data + sizeof(struct txt_os_sinit_data));
+
+	while (ext_elem->type != TXT_HEAP_EXTDATA_TYPE_END) {
+		if (ext_elem->type ==
+		    TXT_HEAP_EXTDATA_TYPE_EVENT_LOG_POINTER2_1) {
+			return (struct txt_heap_event_log_pointer2_1_element *)
+				((u8 *)ext_elem +
+					sizeof(struct txt_heap_ext_data_element));
+		}
+		ext_elem =
+			(struct txt_heap_ext_data_element *)
+			((u8 *)ext_elem + ext_elem->size);
+	}
+
+	return NULL;
+}
+
+static inline int tpm12_log_event(void *evtlog_base, u32 evtlog_size,
+				  u32 event_size, void *event)
+{
+	struct tpm12_event_log_header *evtlog =
+		(struct tpm12_event_log_header *)evtlog_base;
+
+	if (memcmp(evtlog->signature, TPM12_EVTLOG_SIGNATURE,
+		   sizeof(TPM12_EVTLOG_SIGNATURE)))
+		return -EINVAL;
+
+	if (evtlog->container_size > evtlog_size)
+		return -EINVAL;
+
+	if (evtlog->next_event_offset + event_size > evtlog->container_size)
+		return -E2BIG;
+
+	memcpy(evtlog_base + evtlog->next_event_offset, event, event_size);
+	evtlog->next_event_offset += event_size;
+
+	return 0;
+}
+
+static inline int tpm20_log_event(struct txt_heap_event_log_pointer2_1_element *elem,
+				  void *evtlog_base, u32 evtlog_size,
+				  u32 event_size, void *event)
+{
+	struct tcg_pcr_event *header =
+		(struct tcg_pcr_event *)evtlog_base;
+
+	/* Has to be at least big enough for the signature */
+	if (header->event_size < sizeof(TCG_SPECID_SIG))
+		return -EINVAL;
+
+	if (memcmp((u8 *)header + sizeof(struct tcg_pcr_event),
+		   TCG_SPECID_SIG, sizeof(TCG_SPECID_SIG)))
+		return -EINVAL;
+
+	if (elem->allocated_event_container_size > evtlog_size)
+		return -EINVAL;
+
+	if (elem->next_record_offset + event_size >
+	    elem->allocated_event_container_size)
+		return -E2BIG;
+
+	memcpy(evtlog_base + elem->next_record_offset, event, event_size);
+	elem->next_record_offset += event_size;
+
+	return 0;
+}
+
+/*
+ * External functions avalailable in mainline kernel.
+ */
+extern void slaunch_setup_txt(void);
+extern u32 slaunch_get_flags(void);
+extern struct sl_ap_wake_info *slaunch_get_ap_wake_info(void);
+extern struct acpi_table_header *slaunch_get_dmar_table(struct acpi_table_header *dmar);
+extern void __noreturn slaunch_txt_reset(void __iomem *txt,
+					 const char *msg, u64 error);
+extern void slaunch_finalize(int do_sexit);
+
+#endif /* !__ASSEMBLY */
+
+#else
+
+#define slaunch_setup_txt()		do { } while (0)
+#define slaunch_get_flags()		0
+#define slaunch_get_dmar_table(d)	(d)
+#define slaunch_finalize(d)		do { } while (0)
+
+#endif /* !IS_ENABLED(CONFIG_SECURE_LAUNCH) */
+
+#endif /* _LINUX_SLAUNCH_H */
-- 
1.8.3.1


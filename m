Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DBE6F861E
	for <lists+linux-efi@lfdr.de>; Fri,  5 May 2023 17:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbjEEPqY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 May 2023 11:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbjEEPqT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 May 2023 11:46:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD3618DC2;
        Fri,  5 May 2023 08:46:16 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345EYgbV020227;
        Fri, 5 May 2023 15:45:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=p2bE9J696TZtF1H4cxxYur4vu91Pu0HaKVTw2ftvoK8=;
 b=2LyTD2uNyUpdj5klCYn3ihMyseydFyrro1+3/+TqQHYobfMTTYUzKNEb/M/MGSZC60I4
 1mab+hljBcV6iBawM7T2QaHRAvn7m3EGrA5MaSteMzqUjFVpbyJQFN5wlcSmAXHaVYz4
 tiIKf3EhT+fn/ErKZ6tsQFL5kZiW2GwcjSjQR90vUeA6lEGv7gn5ewSdsTo80K9Qjqso
 nAMwos+3/eXqnRBmSDD4tYAWiNu62+w/iXsLfJLoaN/iPxULNBGnKb80zbzWxqATR+dN
 IG21h1y+tUqZQeeeXrRxRyC24+Tnq1eAMTbXrBKiJUGAehcdBLpSjxL8PgLJ/rC4S6Uf mg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8su1w6fy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 15:45:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345FT189040506;
        Fri, 5 May 2023 15:45:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spa33sy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 15:45:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uw6MObw1r9h/60RVvtHHz1kPI3A1gH5NwSlntip3E8xyDbh19JObH4iEaWPWtq7oKprHI+OoH4m6YtM3zW5fTt3XUV9UbAfe9vbctEQ2VVvybwA/db6iVhkU1hgjeKzyws2pPllyDzto7ZDqRl/2gIaHLNZ3ssY5aUC22vTOA5Nwdf8DtthrtoM8A71Ta6A+C+u3A4cahkL090LhIQYCgfXt0uRaEk7fRyzY3St2KSimoBqY4s6m4X3d7ZqRgbPQb+TrxdBJC3qS6P+CsutB1RJE70thpg1XvKZHrfp1UyQTNyzy4/V7cSLsQ9m2s5u3tIk9sslXV7U1X5J7U/kgsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2bE9J696TZtF1H4cxxYur4vu91Pu0HaKVTw2ftvoK8=;
 b=mexy0YS0G9HfI7mMIb7SpHSnOhRT0RvzCejLHfBB+6UWgd4+34aWhzXGwxamzWBrabmJHiEilASLFpSF3EzlCYM4JQ/riJvHCeWZ4m0tP+TYSsC91qofLwDT6ib/mR2dC38sNxN6Oy6QYpjsNDf5vb/PLRaAIX3bRhJoGdvHQf+BP6nLwwIMLhtfJ4zuk14OLqeohALjoHTuTIrU/yW/xm8NaLVp+mjMz53/JxRhu9Sd8uvysMRsnwrCqyKAhNpj20Cu0fPeCxGEivifR3w+VoEHWyrKOO09uhYF/vryMrbsv2VMYwol0MnbKXOYyIOMXjgjlxsFyZGgpPnlD+zuNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2bE9J696TZtF1H4cxxYur4vu91Pu0HaKVTw2ftvoK8=;
 b=z7H+OQou1ftFhKUAsR3RGiTLdKmw7NQlg+Ps0OSrF9/sO2HO7SpK9VbF6GBsVh2h+LNELIF1NaDkea/8lkEbZ10QcpLOnhHHInxLTinq1VVNhJOHqp2oYS0fOXH6VivOcW399NlZ8PqvS9YiDWQjN/lNZGnIzi8oMfTmQDZDxlc=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by CO1PR10MB4658.namprd10.prod.outlook.com (2603:10b6:303:91::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 15:45:21 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a%5]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 15:45:21 +0000
Message-ID: <765a94ac-ed2c-267d-0ee9-be21757ceb16@oracle.com>
Date:   Fri, 5 May 2023 11:45:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 00/14] x86: Trenchboot secure dynamic launch Linux
 kernel support
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux-foundation.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org
Cc:     dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <ZFTA0kg98XxeP2Hh@debian.me>
From:   Ross Philipson <ross.philipson@oracle.com>
In-Reply-To: <ZFTA0kg98XxeP2Hh@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0883.namprd03.prod.outlook.com
 (2603:10b6:408:13c::18) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|CO1PR10MB4658:EE_
X-MS-Office365-Filtering-Correlation-Id: c50e14e8-8236-409a-865b-08db4d7fbb8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pULSpVrBcSRYak7XCabneSBP8A83RbUIfAdnWyftAyMY1ITK7psK1GC62mlHhNLrWXACI+rR0VGVzDVFnLsz6T4VvuF/AGya/le3FiBlvDtTEltn/YkneRs0m/d2QdAv97EFFSVS3kH6jpTmtsLh16I9G4zO8QJPcejIv4wW9+RKshdNL2/LMRKePkNFvhMP4L0RgRL+YsmAmd5BBKln+zqchrBZHRcoo9fMYz8tO8e6P0f3NCqS+Enfis9BdV1Em6wr87WTlmQIN17qetiwqo0V3+8+ieyKW3byT4ztIppCZZYwJkszzae4ilkeQjcRy9+DASAfb1oIUsIPfYaSpM1qTzr644JanPSnpjYHMvC8OodctQrFA5Pqm/wGM+JrcX5nfQGcUrFtM/wl8OzX/HDSNom1ottM+bObEm7oRlzeUuwzCXAu3GMhDn4mmt0P8YFMiJOKZZKUuGlH7SpL9vqD+EXHkmAsPKkOi4ScQBmpqxkHflfmX+dmqQV/R0SL8Lg5ToUB74EKVvF2oY+KB9gHRJNMZ3/RWlW/YnuOtHbGhP8RUkiv6lUre+fLipMdmKhB/eIpRAshdSBMwEirbePRZXAGQmIc/lTvzpRXhkyrwblGBwB9RHNHsHUtfV5z+lU8KPj5bVyV8wI/NJO8YudF9Zl7JIjeBQdrZReFFj7N5KgxvUNb6BhBx0tzvcpk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(366004)(346002)(39860400002)(451199021)(31686004)(966005)(66476007)(4326008)(66946007)(66556008)(6666004)(478600001)(6486002)(316002)(31696002)(36756003)(86362001)(53546011)(2616005)(6512007)(6506007)(5660300002)(8936002)(8676002)(44832011)(7416002)(2906002)(4744005)(41300700001)(38100700002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmpLaTAvQ1dIN2MyZThGZmtMWW5YZ2JBNzNHVGNaa2NUS0FaVzFSRHlZUlJo?=
 =?utf-8?B?dHY0TnMwWnkyM2hydHpjNkdBbG4zOFZXWWZZMWx2T3RYbGNkMGJ1M1EwbGpS?=
 =?utf-8?B?SkU1U0RtQndWaE9pazFjMVB0UEEvdlVGRk5PQXdRUGcva2wyNUZhbTBJWEpM?=
 =?utf-8?B?RkFpR0VOM2dTOHN2eVVZQTA4U2RkUnpURDVrdmcrZ3crRFAwRUFQd0hLZWha?=
 =?utf-8?B?UlFzYURFVG9sQnVFWVNTN2UrM3NIWncrRVZ1cmFNc3A1MFFNSU02amZkaGtw?=
 =?utf-8?B?VEpVeHpyK2ZTYzV6T21BMEJxbzJXbWpveFEzQVZtWDI2Y243dFFyV0dJZjE0?=
 =?utf-8?B?WE4zckFXbmZEU3ZyanR4Rk5JY0JwUkdlelY1VzBKUkRBTUl6ZmVYQnNBQ3dm?=
 =?utf-8?B?R05Eb0NxRlpmRkRUR2Znc0M1MWFHUnBVR1hJRnNqcWtkbkNuUHZjRzY4ektm?=
 =?utf-8?B?Nnl4b1dUUm0yV2Q3OHBQRVR5Y1BkWGdhUVkybTV2alFaS1hkZUlUc2NSQmhQ?=
 =?utf-8?B?T0M5c1BSSWVTTzdpZFlFR2pyaWFPcWd5T0ZxRVNrc1djaWVsWk11ei9SZTU2?=
 =?utf-8?B?ZXQweWt6djlkSWUrSDY1VWx5YlI5SlUwcUZ1REpVWVI1WlJDV3V0VGJ4Y0RZ?=
 =?utf-8?B?d3pHNXp5eFlCZnRQdEc0bWUwSCsxYWpEWkM4eW83bmpGL3J0akV2WHdaQUNZ?=
 =?utf-8?B?N2tSd204dE9PUEtkczgvVW9UMk5rY0pUaEtWV041aGJJQVJuOEtVc0RwUHd0?=
 =?utf-8?B?NUsvTjdQQ1V6NndmUWt2czZ2SEpyb09Ja2NyR01mR1VqbFc3dUdMSDFFejV6?=
 =?utf-8?B?V0E4V1YxRlVxMm90OXNaUVR2MG9GTWhUdkVIcnh5MVBZS2VicWR5UVdYU1U2?=
 =?utf-8?B?Y25TWTJGWGM1SjVKRXRVdGw4T2NLODJJMDhuNlNVcnNYRFh4VHlDRmU3VjZm?=
 =?utf-8?B?YUsxOGRVU2loWkh6WXYrcmhSZ05rM25xSFdQNE5kNjFxSlp5OWZpc0hoQVJi?=
 =?utf-8?B?VlZTSXZET3dtWGZmSzNNSnZMTjZkWXpHbU9uY3NVU2NISGJGOVNidU91dFNx?=
 =?utf-8?B?Nk5RcEN1WTZDcVdpZzFyVnozemZwbkZSUFZnaTM5UzBwQllGWm1kUGJhWHBu?=
 =?utf-8?B?NktpTGozYU1rWjRPV0V3L1JDc1JpRFlOMXVPblpTTERERnB6dDhML01BamUv?=
 =?utf-8?B?aVNoaTBWZUllN2xXbFVBaXBRS3ZCZWJFSndIWDNtUTB1T0NCczFLakpaR0ZD?=
 =?utf-8?B?ZHFyQVFBbyt6MFlGcWl6Q1h1dWJyemROZEtUWnRZNklHZEtxRXBieW9MWUhl?=
 =?utf-8?B?T2Z3WTZUcjJZZGJsTjZUVXdXT3I1MCs3MTE5Y0l4M0NRbWxacDAybmdwS2tD?=
 =?utf-8?B?bVh1Z2tJNllpdzR4MEdodHBKMEpVQktxaWc4NmU2RU9XSzI5aU04UlZRbVNx?=
 =?utf-8?B?U2hmbnRrTS8wT3oxZ1UvVkgrMy9uUGs4Y0VaZ3VBd0RkeG9nVW1RSGs2NUdC?=
 =?utf-8?B?QW15UlErUTFPS01JbTRlY0YxRTRsckl5SUlZYTl6NjFrQ1d1a2JHcWxSTXBG?=
 =?utf-8?B?bHZsNWNBQ0hDWnF1eHZZWlA5NUZwa1ZOVU1ZbzRSQXdEblFlb2hzK3E1R1Ux?=
 =?utf-8?B?a1BDaFVyQkZBME9mVFRvbEovbDdLOUJBa0IxbmNWdkxUUTgvcVR1QWNpRHhz?=
 =?utf-8?B?VWdUS1pBVW1teE0xQUpISzIxSDA0UFAzTUhBZ3lINmNaaXJTdzZrUERkM0cv?=
 =?utf-8?B?QUJHSzJpWEZkUUc2NzZTb2tCK2FMNzhPeEUrMzZUMXRvNzlNbFI4cDc3MHE3?=
 =?utf-8?B?dGpEMkJVWUFKLzdXZUNWTSs3SWNKVlRjQkNyeC9wb05zdFZXSGx2di9XbFE2?=
 =?utf-8?B?dW5vWnhiR3FYanhrMndCalUyYWYzK29uRTI3ZHIyUDA1TFBERmgwK3JONGV4?=
 =?utf-8?B?YW5JZnI2ZnpLeVRRdXpqTmVUK1JLK29vNWswMm1KQkxZZWY5UkI3cFN5ZldB?=
 =?utf-8?B?SlZoQyt5QUw1VXl2K2MrS2FoMG5ZUWlFWmZ2NkNWQnV2NzJ5NHBnVktvbXgx?=
 =?utf-8?B?NWVDcDNIckJGeXJtdlpadjQwYU51b2t2QmZhNko1Z2JjdUYrMHErWkpmYVlK?=
 =?utf-8?B?TVkrcDVGYUI2TUIwMTIrMkc2aVdzQWNFeUxabjMwbXpkYnJPRENjeGM1cWt6?=
 =?utf-8?Q?ftn0he966O1NElT0gDDHVw0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cEhCS3Z1eEZweVNzaWZBRGRlVHpHaGFRa3BkTWJyRUFJUmFYTmhJZ0szM3Iy?=
 =?utf-8?B?b29uYkwra24ySXF3MXZ1Y29WditFelY1amtzR1pTWU1nbVVDSVdONklqMy9l?=
 =?utf-8?B?RlhqMEU4eml0emNhaFoyN2lWR3VNNGRVWFZ1UjZES3pVQzhFVUdnK0tWTkY4?=
 =?utf-8?B?b3F1Y0hUWEFGYzJyczBjSWg0RlFxZ1BJNUFyYithalBJdzd5RTdEcmpoKzJa?=
 =?utf-8?B?SnA1b0xxVm1OckRmVllIYVBWdEZkOGo0aHM4ZWsyVHM3aGtrcnozalIzQTNP?=
 =?utf-8?B?UWRxTTFSUlBxY3g4dGRjQ3FVZE9ib0FvME1MazRqTWhuc09YSVR1NjcwOEJn?=
 =?utf-8?B?aGxYajhuc3ZBZW1aVDJyOEdpNGx6cU5lekNJU3hPS0IxMy82dEF0b0E0MHJh?=
 =?utf-8?B?b2xXbksvM3RrREF6NnV0cGQvbktzY0sxc2hLbi9mVWZUUkV0QXFVaGZnbXc3?=
 =?utf-8?B?Y0F0U0JEQmlLN3hsK2dFeUN6bEZZNmNUazVvVkZna0lxdzNQSVIzQy90WWtO?=
 =?utf-8?B?RFpPTkdiMzhlU3NEa1VZN05hNnA0endyRThkS0YzMEg5MzcvaHBXRDB6NVNL?=
 =?utf-8?B?MW1JQmJBYTd0U1cya05FNEhuYWFocnoxRmY1KzNxaXdYWmZFbEJBSm4vV1Mz?=
 =?utf-8?B?cGt3Q2IvNUFSaGJxWURVMGpoVEx5c1Z3NEJNZlFWSmtLWG13VXpsNURIVVI3?=
 =?utf-8?B?VGxRM2M4WXc5K3JSWWNxV2VzLzNjV2xuSHZRYmRiRk90a0F5ank5YnlJcGxZ?=
 =?utf-8?B?T3BnWjk5a2VPU2lZL0xramVBQmpDWktmZC9oNGpoQ0ZmSnhFTlFLRlplNHBy?=
 =?utf-8?B?b3dWWnpQQ1lHOUx0N0hLVXRvOUdycVVSM05KS1FRNDlSYTB2QUVST2h0RC9N?=
 =?utf-8?B?azJGeXhqcEU5N1ZTLzRwOENUSDE3Y01Tbks4cVMremNOOSt2Z3AzS3NseTh5?=
 =?utf-8?B?ZStpdU5TSVorb1hSenh3V1JmSGxvMm9IM1JsT2xOWUhsRk1JRTVqc05xek44?=
 =?utf-8?B?NGwzZTFSaUU5VXdwK0ZyYlNFL0JvQ0h3bE1ZSWZvWWQyNmx5Z2grRG1XZmJj?=
 =?utf-8?B?Y21oSHRpVWJuVzJ5NklSQ2YxdjdhWWVLY3Y0Mk4wdnVibnNEV2NWVkJNQTVt?=
 =?utf-8?B?NjloK1dDVWJMbS94RXYwS1NlZ0lZWVAvQnJPdlRNY1VyS3cxZ3FGQmtLTG5R?=
 =?utf-8?B?VTB4NlBsTm81V0N4emMzblZQWWtyUUt1RllOQ3dCZUd1QVNSMXh4YkRVRjJU?=
 =?utf-8?B?UVRPN1IxVmdKaDdsejltNVorNXV0LzZPSzlvUDhFTEhPcmxPTFZpRTlQSTRV?=
 =?utf-8?B?VXdobVVPRWU2NVFkYnRYbktZZlB4YS9WclJIOEQxQ3cyVWhxcE1FWHJUdk1P?=
 =?utf-8?B?aVA5a0FYaTZRdkd3SER3K1ZZVmw4WGpqdVJ2c3NmQVZvQWJFWHFmcDZjbi9u?=
 =?utf-8?B?VnErL0g1RWxiRHVtSHlvb2Jhem4wSVNNZ1E4aXZKSjhzRnl3T1paQitTNzJo?=
 =?utf-8?B?S2JTNmZLQkRPYXlpV29KeHdxRFVhSTNQVVUxVmRiSjZCZ2VuRXg3WUpFSkh0?=
 =?utf-8?B?Kyt4c3NNd0dFbDQzbGpOOXZVak1seDc1NWZLcHc2TmVGZDA1eUVZT0tDaWtE?=
 =?utf-8?B?aGpadEx4ZUREUTJBdERsWTgvVVgyWGkzTGxnZ3NSanJMZEE4MWhURnVBeFNZ?=
 =?utf-8?B?RjR4dWYxL2FlMnpCWWtLRzJPWC9jekZtb3RJdElSdjZhNFZKTlVvTy9WOGJs?=
 =?utf-8?Q?QhimvoHAB2/0W9mef90e8mNEakY4XMSGgMGz7Pq?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c50e14e8-8236-409a-865b-08db4d7fbb8e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 15:45:21.7076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UctS69RpmiNHYwvQ4gl9/HegVyN3phWvzzS700koVHPuYJQjrrzD6PjSWak8aqi5QtrAVYck1qIzsxVkobI+rNwoR69zlVlUT79RiZacFC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4658
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_22,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050131
X-Proofpoint-GUID: Y7PQ1cSJOPS52EIpDN0TlI9Ec4pc9Nmo
X-Proofpoint-ORIG-GUID: Y7PQ1cSJOPS52EIpDN0TlI9Ec4pc9Nmo
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/5/23 04:39, Bagas Sanjaya wrote:
> On Thu, May 04, 2023 at 02:50:09PM +0000, Ross Philipson wrote:
>> This patchset provides detailed documentation of DRTM, the approach used for
>> adding the capbility, and relevant API/ABI documentation. In addition to the
>> documentation the patch set introduces Intel TXT support as the first platform
>> for Linux Secure Launch.
> 
> I'd like to apply this series, but on what commit it is based on? I
> don't see any branch containing this series version in trenchboot tree
> [1].

Sorry about that. In the future I will include a base-commit field. It 
is based off of torvolds/master as of 5/1/2023. The branch where the 
patches came from is now pushed to the TrenchBoot repository here:

https://github.com/TrenchBoot/linux/tree/linux-sl-master-5-1-23-v6

Thanks
Ross

> 
> Thanks.
> 
> [1]: https://github.com/TrenchBoot/linux
> 


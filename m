Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF33700C5A
	for <lists+linux-efi@lfdr.de>; Fri, 12 May 2023 17:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241474AbjELPzT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 12 May 2023 11:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241775AbjELPyz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 12 May 2023 11:54:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2203449D;
        Fri, 12 May 2023 08:54:52 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4C7T002678;
        Fri, 12 May 2023 15:54:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=PIEHvZoJ4mBPuUyq3EvJtuMtIILlcjjllAiIuPIf2rM=;
 b=uWIyChutMpkMTC0bCk7zYJ1ep79l27I6HVURAF3EhShglHs3TCvdS7n777y5Zwa7zpdO
 Y/LXDMJoEKhIXOOR8ZdGJ4fLbVj6YyXWMoLlqHkjJKzi0Z8M2JoXtQrimjNEHVO/ptIG
 yeu7bqpflwOehkbj49NLBQNL7wVz+rjC+LIM96U9ImUTMH+RI5R2pW9Kiopx4crU1Kgl
 +3qRd3xlEtwPcsYBdK33VteSxU3fUptyJLQW4J2b93GC3pNb+cJkF1RFjF+vzLO6T0cV
 XHNEo6Kj/YA0jgBOC9r7sYmyWRmJlrFs8Cit44frDyH5JENJzOJ0T18gLCOo1xoxBgnx KQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf777b0pd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 15:54:17 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CFHgfh011610;
        Fri, 12 May 2023 15:54:16 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf8151jd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 15:54:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L22sU+m5wEL3GO1D8e0VY9OLnhiaOoE1zqNnuLBnBRt3pH22+6bxFh6JUtyPYzg8uS/uTTNYcZ+QB0rXLqUIabUDETf/YJyZutHLEqPuTOaFHcDNRxvnDVdefSFLzR+lhair4K5ART5I6cToOeWNq7NZ4gG+n5NnrDzK+tqZKw8AjaY3owcadlJ4Nz1bjbAyncZQvrlZzFHh68TGD1uX6MlZJBt/RHbiO1xfowv/JpLAKKR56fwV40uvFednH/BOVKrSiCHwnWU490TpmPYktBvh7Yo1J6SASsB+VEpLEVDVpKskJpkbXSAHNfu03TpNjkZu/3V526/GknD+Y7XLPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIEHvZoJ4mBPuUyq3EvJtuMtIILlcjjllAiIuPIf2rM=;
 b=Ks6wda76waxd3puNP/05tCoiYbKoYtnpj+G+4ukIs5arNiqqRrHtz1PEkZfJ+MPKdVLdCOV3Uk68sULV8T0Vg2YmYFDGmuBrYhWD134u32D5SoTHYuASHnw2wKMtkUbLcAO38OvuNoia5l4VoNqCvhDAlx/RfSKlB//ozJgpQBd360tr7O/M3toSEIoDWhaMmuUL/9i5UH5s4hsngkKRxatOli4bQ73V8IxyrHI/h1gHM1p3wHsZI9ShdC/rVttRV3ai0P1jKQiBbcWj5hpDunZ5sGoSpdVJRxh2saEvoKVZDgfSCo1NofdEkotnGJepyQ0oeEIW2Q+OXABQ7ZuoQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIEHvZoJ4mBPuUyq3EvJtuMtIILlcjjllAiIuPIf2rM=;
 b=P55jgUO3Ac50fyDoecRJw9RQ7PhrpFedlI2CplKKG5xd2h+IBXabS7A/1xwf22t1H0xjPt5FFnSJqpTUUVpc3xgH2s5mU0to7BAvQ+xpLPaeYzl/4aNcymx5e0EGocDu/bmIjTQCMmfWJiiFSGqBmM/uXrH250fPaLniKG126r8=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by DM4PR10MB6694.namprd10.prod.outlook.com (2603:10b6:8:112::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Fri, 12 May
 2023 15:54:13 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::37d1:ec08:a280:1d91]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::37d1:ec08:a280:1d91%4]) with mapi id 15.20.6387.024; Fri, 12 May 2023
 15:54:13 +0000
Message-ID: <3ff0d84d-1585-f11c-0b1f-b773aa26b637@oracle.com>
Date:   Fri, 12 May 2023 11:54:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 12/14] x86: Secure Launch late initcall platform module
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux-foundation.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org
Cc:     dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com,
        Ross Philipson <ross.philipson@oracle.com>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-13-ross.philipson@oracle.com>
 <CSIYK2ZJ6YRH.29WEQTLNYMDUF@suppilovahvero>
From:   Ross Philipson <ross.philipson@oracle.com>
In-Reply-To: <CSIYK2ZJ6YRH.29WEQTLNYMDUF@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR10CA0004.namprd10.prod.outlook.com
 (2603:10b6:408:143::18) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|DM4PR10MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: 137c6c42-0d26-406f-dbe1-08db5301219e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aoYAf3hCNfs7ij6x0WUW3vrUAelnxrK4ZBEcYXnRNhTYHFIYmXUqc8y3173KRJwGyML58UyULmho6Ee0MKbPRy20dVbo4Iuj7d2INkqvMVKM078Sgy8QYw428Lu+RQVsYDtUujTaSnnUFwqx7H5htvn5fKPY7GYtkCynsFed5gCOpxWqV31t2VVDlCURz/dJ+ZhWySjMYcoDc9SLDnnzfSn0fIjWtQq0r9h/eJvEXSxf+wsFMi+MpkAfjRlodDNMX0FLMvA6JluXPGgxBCAs4XDc4uNrY/mRU5peTkIWdB0rE8/ItaX2X69NK8C4++XYQ4RDE3U9IE28E66p8AqNNLsmq7ytAYWWcY5y4oDTsxNpMKPpVRR2xDqfg7REFQeLyOoSzyyRDlskRUu+owCO4nxAFcjstmcfftR5x5V90E98aVRsIMYVQcig3/+OMoBv+4ohtTMK+NlDFv6cqfspvcts5w/l82bVqaoSyH5DZOmRRqcPwo5g15tj7FDU8AibiBLjEFpOFm2Y0mk9kLugllTi4OnBxShoGbdt9NL6zJx4zi9vzVgafWwtW/gk73FfV0tzoBMSxuS8yoCkSoeegwlihy7OVidh4P/k0n60fZuhPElLmyZDlNZdqZ9VHkG2JPp8qAfSX/U2Y23G/y4tRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199021)(38100700002)(107886003)(8936002)(8676002)(31686004)(83380400001)(41300700001)(2616005)(66476007)(4326008)(66556008)(66946007)(316002)(7416002)(6506007)(6486002)(6512007)(36756003)(478600001)(186003)(53546011)(31696002)(2906002)(86362001)(6666004)(44832011)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU1Na3RTODlYMm9BM1NrdmNRUzJIMDFtU2czT3g0RnNoTG1EUy8zdUdBNVY5?=
 =?utf-8?B?Ri95YytoNUpxUU9ZQWdtdXVHNkJEVTRuem5oc2sxVW5tOXdxMklLQUVWZ0ht?=
 =?utf-8?B?NWVqaWR4QXRZYjJGZVJuVlVUV3ZvYkRoTmo1Q2l3NU1LRjl5RGJ0RWE5VWFN?=
 =?utf-8?B?Ly9DQmtHOU9ENC9LQmdveDhtL05BQk55bkF2YzFPb1FEbFlYSVZBZnF0cDQy?=
 =?utf-8?B?TUh5OHFQZmVXV2FWTk5OQ0JrNGRhd2JZanBkS2ZDNzAvczE4VzdWeVJrME1l?=
 =?utf-8?B?ZXFVSzJycU1vVHpjS080NVQ3dGJJMzdocFQ0NmcyU3NhSTQzY1VRSFdya0dD?=
 =?utf-8?B?dVBWS3F2UzRaWXNRQmtoeEdTTDJNMmFEWlRvN1pvMlpiN2dEZUU2d292MmJK?=
 =?utf-8?B?Q0I1YUJ3QjJiTkhPc1J6Szh1enBRSDhWbytmaHpPWEx6eCtNejR1d1psK1ky?=
 =?utf-8?B?cWFzaGxYRW8wdlpRRU5jU1ovcXpHS2kyaXR1RmVydkxOaGQ3cExpK0l1czVQ?=
 =?utf-8?B?MXpkaEs1NkpzaXJVb1BUVEd5UWNBQ2l2VVFGWG5pQjZ1aDRQRDdHNllkVHM1?=
 =?utf-8?B?SmdXRGNnUTZnNFlyVXNtSTZEMG05N1piNmIzUG0yTi9ReTNFZHBGaUZVRjZq?=
 =?utf-8?B?dDdCSDErSDhUdldXa3FhT0NCVWMxb1lkTW1PSDVpZXpjRmk0VEN6VThwTjYy?=
 =?utf-8?B?WFpHODFJRFV3d0NBQkVhbWhlZ2piWHRYemlaNUR3TXFFdEVqRUJQUERZVy9E?=
 =?utf-8?B?R2RhYzMxaVZaTDlMd3IvZndldXBDUWc1M0hLY3NTRHhJaUorMEE2OU5WWUZK?=
 =?utf-8?B?a0lPMUZrOUpmS0pEN2J6dmxab0Ruay9Bdzk1S2svVUdxYzRYZnZYWnJ3MEhO?=
 =?utf-8?B?ekdrS2c4T21mRmNEeDBWVHIvVmZ5UXJHRy9DQ1NmQmI3TmRFMHd3MFNmajlI?=
 =?utf-8?B?RTVjTFUrK0RRNGZtM1hWNmZXVnFkZGRlWk8rQ2xRMitFUTBPc24rVnFBT3A4?=
 =?utf-8?B?cmRMN1BLWW9XQzZCanNPN0Z6dWtRQWlWaDJFWVlNd1FWWnZnRFZYOFg5YVlO?=
 =?utf-8?B?OW10Mjl3d0FtMEpWZlFONXRWb3NDckczMys5QjhhS2I5VE1vUFhqU1Rzckxi?=
 =?utf-8?B?cC9UU293S3BpL2o1dFRxTk4yK3MrYXF0QXVIRytISjhtZ2ltcUhIdHN6a1Qy?=
 =?utf-8?B?T1NUZEJCQmhIcEZZNVBVKzJJZzh5VWlwZ3lWZlB3YVJpM25LbHZKYnhxeFd6?=
 =?utf-8?B?MHM4dHRtODMrVVkwNmFLc3lnRCtGWkdKc1lhNUt6S0dPRG1VRUVHYmJBNlU5?=
 =?utf-8?B?ZEIwRGE4L2o3eFpzQUc3N3Z5YWNsWnp6WHRVWEg3eUUxc1RSTlVyeVd2aEM5?=
 =?utf-8?B?RmRRaGlobTJwcWtkUHdxOHRPUDFLTEs5UFBRV3BvSzJ2czZPZFlyRHVNZlZG?=
 =?utf-8?B?WjcvNUVyOG1oUXJIaHdHdzVMS1Y4ODRxcEM3VmFZMHN2em9oN0NqTGJQRzNU?=
 =?utf-8?B?M0djRFhHMUdObHFvNW5pV2kvdEhVS3lIS0IxVUpjM3RCNmkxSWtWaXNabkVZ?=
 =?utf-8?B?aWxubEkxTnpJZW52SW5yUVdJN1VMSGcrRU0xVXFTb0wvVDlraVNVRjhpU3k3?=
 =?utf-8?B?a0I2dkhIWm5Vb0ZwK0YxRi9HUE90V0tPd2FJbmE1Q3BFTVBJbkVSSTQzOHM2?=
 =?utf-8?B?cUhMZGQzb2oybnFBWVpRSmRpNVFTeTNuZysyS1JYZGpMSEQrSlBlK1NZTm1Y?=
 =?utf-8?B?a3plM0Y3SVlwUllMN0kvTHZxcjJXYlFyWGVWUlNaN3BvS2ZORGtaVkxodnRW?=
 =?utf-8?B?Y3loRWpxbVdRck5UdWVRaUZRRE0wUk1JaG0rTi9sa29QY2ZQOWs2TFlNRDZS?=
 =?utf-8?B?dHpFN2x3TTFrRzBVNHBWemprd1FXOWp1dFZqTkM3cThuWE1Ka1BFQmJUNEMw?=
 =?utf-8?B?Tjd5b3pLNjZPMGhaQnJDeDJEcVBtNm5oSXVWU295cjVqNXRSV2JZczJKYklZ?=
 =?utf-8?B?T05FWWVCdlQ2OEM5VVovUHRxb3U2dnBzam1tM1NzT1VsbnladE9CU1dtTm8z?=
 =?utf-8?B?UCtkT3dGVHNObk02RnIwaVQyN2tCbVV5Wm1abkp3QWJkSXlJb2E2QXVzYlE3?=
 =?utf-8?B?THlnZVlmUFhQYTRJNW5hUjBxVXRXQW9qQnZ3QURjaTBIQzQ2ZWNtaHUvNGRN?=
 =?utf-8?Q?+SFrywVM7VUWH4QKdikrHEQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ei9tQWRzWi9WWTdXL2o5c1BpVHlqZFB5eWlZTkZpOTZoSkIrL2JaYndua3V5?=
 =?utf-8?B?VnJjRm5pYjU4bGpIOVZWSmgxd1hzQkQya2VuVGxhTVF2Slc5TEJGTXd1TnJW?=
 =?utf-8?B?dzFONmk1L0ltMkpEbDRESFUvdVZlZ1NUTnpzMHgrcmtDTEZWUklSU3JNUHZ5?=
 =?utf-8?B?NHpOcy93UHd5VHZIZEhaUEI5R1pGQ2ZjcEJPL1Y2alFVb3ZINnhScWpSb0Y3?=
 =?utf-8?B?bVFOTlhJWWp2VlMvaytVQ2pKdGgvUnQwWDJhMjl1cDhZSGFjQ0gvSk41Sml2?=
 =?utf-8?B?LzJkSjhYai9sTXVEZFZwOXZhbWNIaEc2dU92emMxYTZOOWJXMkFDVnN5Q3V2?=
 =?utf-8?B?N2w5cjhLRjQyQ3ZFKzB4UUoyRWlLd0NSN2VrOTRabXBpU2dzbE5MZGZ0K05H?=
 =?utf-8?B?TjVuTWxROXVGeFV4N25vQThFeFV4bElJd3VCcXlwalhSWDNqRzh3dTUzcEJ3?=
 =?utf-8?B?Yi9qbnBjSlZCZXZDdm53QWMwNGpYTzBkUFQ4ZDZra1RrcEtFaUh5Nmo0WGQw?=
 =?utf-8?B?SG1md3F5U29oUktIZThoYll0cm5MNEVIT2ViWndEZ244TmpXYjRyMkhFTjZ0?=
 =?utf-8?B?bWZvSzdTUHdQaUwxcnphVHpITk1ya2t6YUh3ZkhlT011NUR5Z3ZJNHdaeVRS?=
 =?utf-8?B?VHpROFo5TnI5eGFlNUJYL1l3emt5d1NiVTJsMk0vaUdCd1NOY3RPUzFvSjRW?=
 =?utf-8?B?RTFaRmdjeUYzdWtrY3dGQW96TzNzWkgyZGFBdUgwY2VLR1lqMkR3T0krLzcx?=
 =?utf-8?B?bS8yc0Zwck5zWXd5RzJ1Rk05V3lwVlZ6UkNtUk0xUW5SZmo4empkWVMzYlZv?=
 =?utf-8?B?bFNaM3dFMS85cGthYW50eVhwWDJUc2tUVEpPYXAxLzlDOHFadEsrR0hKUWRk?=
 =?utf-8?B?a0ttY1l0RGJ5UVhKYVNoNFZUZXM1SkVHd2FpRHVoM1VjRlNQYmxHOC9tSjRR?=
 =?utf-8?B?STJRU2RCZ1oxNjJEeVNOSXBaSndRWGQ4azVkTUt4eVFDVUJiN1FiemZVTjRV?=
 =?utf-8?B?K0U3WVkvVHFtSlptUnNRZlh2ekFGQUhIdHR2UnE1bzVBNVh3a0JpYkdmQnFl?=
 =?utf-8?B?eDRvTVZQalhIbXh3T0RxKzJDN1gzTDJKR2NFNWdjaWpmRGYwY0dtTHVDcmxY?=
 =?utf-8?B?YnhTM1U3UjIrTnlXOUEyVEYzZ1JsUWJNcnFNUEZlTUtTVkJYbGkyYm9UZm45?=
 =?utf-8?B?ZWRRR1FIVlJpUVhucm5YbWFGbXF5Tlo3bUZkeDc4NDFnYmpVRFU2WEx5NE5v?=
 =?utf-8?B?WXNTS0R3TVdlc1RlazZNNCtzTkRQRUovTmJZQS9qRW1yaEJjZnFPQzFBRG5q?=
 =?utf-8?B?bmNYTjRHUW9IT3UyODh2OEdDWkZIRmZpSWxsYWJmUUZEaFB6NzNpNzVTenNF?=
 =?utf-8?B?VUJzdVgrb21LVUY2OG9FLzFRR2tMUGxOeVpqdk5YOVU5VG1HK1N2NTU1b28r?=
 =?utf-8?B?SURadjE4T2YyVVY1aEdRVGFCd3BBcWd5U0IzTnhMcDZYZEJZeTFBVklud0xr?=
 =?utf-8?B?cGFrV2RhOTM1a1I0RElrbnBmNnFCV3FEczVkZ3l2L0NmdE5Yd2JtelR4ZkhD?=
 =?utf-8?B?b2xsT3BiSDNZUkt0Y0RZbWxDRlk2SWhLZzQ4RWpvSXFIS0tGbkoxZHlhekF6?=
 =?utf-8?B?Q1VOYksySXM2NUo4RVRRZWdCVDJaZTJiTDZ2RkJKdWhuUXlvZzZlZW03L2FK?=
 =?utf-8?B?MlZZcjE4QXhLTnFtTW1JTTduTDR2bzh5UExsMFFGNWdCZUpNczV6WjdKSW5O?=
 =?utf-8?Q?/7UGr0gS02d5pQF8Ds=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 137c6c42-0d26-406f-dbe1-08db5301219e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 15:54:13.4877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8NA3jlgiaLQFo/doKvaH84/0IRBateloD4d0+tWpfGl+xNXw7OunL4JxRO6c3/FE3Kb1R+KzmcTTcuksEB8vMEzTWsy5e50F8mOiXJ0ixs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6694
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_10,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120132
X-Proofpoint-GUID: u150m0gYK4SoelS-GVadsg9CjrCHtqnI
X-Proofpoint-ORIG-GUID: u150m0gYK4SoelS-GVadsg9CjrCHtqnI
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/10/23 18:40, Jarkko Sakkinen wrote:
> On Thu May 4, 2023 at 5:50 PM EEST, Ross Philipson wrote:
>> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>>
>> The Secure Launch platform module is a late init module. During the
>> init call, the TPM event log is read and measurements taken in the
>> early boot stub code are located. These measurements are extended
>> into the TPM PCRs using the mainline TPM kernel driver.
>>
>> The platform module also registers the securityfs nodes to allow
>> access to TXT register fields on Intel along with the fetching of
>> and writing events to the late launch TPM log.
>>
>> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
>> Signed-off-by: garnetgrimm <grimmg@ainfosec.com>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> ---
>>   arch/x86/kernel/Makefile   |   1 +
>>   arch/x86/kernel/slmodule.c | 520 +++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 521 insertions(+)
>>   create mode 100644 arch/x86/kernel/slmodule.c
>>
>> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
>> index 3d2a33e..ee3fe300 100644
>> --- a/arch/x86/kernel/Makefile
>> +++ b/arch/x86/kernel/Makefile
>> @@ -73,6 +73,7 @@ obj-$(CONFIG_IA32_EMULATION)	+= tls.o
>>   obj-y				+= step.o
>>   obj-$(CONFIG_INTEL_TXT)		+= tboot.o
>>   obj-$(CONFIG_SECURE_LAUNCH)	+= slaunch.o
>> +obj-$(CONFIG_SECURE_LAUNCH)	+= slmodule.o
>>   obj-$(CONFIG_ISA_DMA_API)	+= i8237.o
>>   obj-y				+= stacktrace.o
>>   obj-y				+= cpu/
>> diff --git a/arch/x86/kernel/slmodule.c b/arch/x86/kernel/slmodule.c
>> new file mode 100644
>> index 0000000..70dcff5
>> --- /dev/null
>> +++ b/arch/x86/kernel/slmodule.c
>> @@ -0,0 +1,520 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Secure Launch late validation/setup, securityfs exposure and
>> + * finalization support.
> 
> /* Secure Launch late validation/setup, securityfs exposure and finalization */
> 
> 79 characters (max length allowed is 100).

Yup will fix.

> 
> BR, Jarkko
> 


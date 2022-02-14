Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3D84B5008
	for <lists+linux-efi@lfdr.de>; Mon, 14 Feb 2022 13:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235468AbiBNMZk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Feb 2022 07:25:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347210AbiBNMZ3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Feb 2022 07:25:29 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C53496B7;
        Mon, 14 Feb 2022 04:25:22 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21ECIHQu023929;
        Mon, 14 Feb 2022 12:23:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=WkGHIxKGn+0/IEA3vgm37/mjquaPyRgbhG7ipcGsuWc=;
 b=cKeHtVEv7+kPh3twfSuWWVevkPAA8+xrEqZ/8jGS+vkkaUNvodMEE3qa/vjpI7jRULj4
 EJ7q37CoNmqZQitDLWuQ+MAkhf4kuVZJIxOAana9X5EKsaZLMTjIz5kQQsT3g3vReZVl
 2/LunsgNPxA8pRee1DjhxyK8/chMelTIAXOQYetHnQs53s9Ku308vSAlW+3c7vUOC0hi
 s0X7CJHVVIBiUnd8FPuCamlD1mhWPW0+1i5REzP3Z1XIMa/XYbLMYqEfUMTBKCtheSPc
 iNuI6dylfx1sjKMjuIHhqcb6aMoSm3NcBxmNRPyAb5zMuj1KtOxAAF16zHvZQ1HGNfMQ cA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e64sbv4rs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 12:23:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21ECG3wa165129;
        Mon, 14 Feb 2022 12:23:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by aserp3020.oracle.com with ESMTP id 3e6qkwkbdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 12:23:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FC0lJw9wvyuF1Pu0gdzKMhfDq20LwwQx07YIUnCBTW8e1EennIkeIFoI7olV/x/fb9evqqRZmmKpvg9aIbaMO6oxmeZl+ilIvbMJLqDbe3nOopHv/9KAX4e2nyCdYrABnkH8XpFIhNJLc93HkaKIOoTXhY6B4g0k/Llp3k4IZK4sC6d5BQ3uAooZ6jNCIAoo0dN34ZzMohZ8Quj+eMEA5f2HbmHusvhapoCAZGcNhHk2tvYD6u+2Sx5bByS0RfgSsDI2kQRm+g9Jfe8bPRxjRS11VFhuGcxkqWEe7C5CXUqZWuH01toMtoMuH9Mp9cwg6shlWlhL7w6kCB/dNEJUcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkGHIxKGn+0/IEA3vgm37/mjquaPyRgbhG7ipcGsuWc=;
 b=Eq50SDPlM3PwimcXXz7QmY56jCoHI9pfPkSjxV1OnFvQSnVrCCtYOorvVfRCcWx2hDmGUhKkpFANqpUQwsBXNldymURJvzwFL7xbyzxrvb9+fASE5b/W9NrO0dkUT9yervAzpsi1MYizX/mEijmVnlVNN+G+0m9OSh8l+mjOC4mT0xfgL7ILwQdl3Oz/3mrqZyAsMCwlc4aWGoWzuP6UwAt0caRxSSVNksveYYe70HQV4wUCvGDYMeFqDrtOxOjKaLFCtwCx8xXzq1M93eOiDLEqaT+rJPXuHVJSpSmYJPljRRevD+fJ3GYvAqGwVjaoeG3mTTj2hY/1Kb/aph0hQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkGHIxKGn+0/IEA3vgm37/mjquaPyRgbhG7ipcGsuWc=;
 b=cT28e2pOgnv981K7jyu4pxgjFX1fWf5zoKLaqe2vKw6sPyivUUwqbliVFyHmzu0Rt/h4hZWQhYuLGou+a+48Tskg4GpTaCXwVRqy4pZGUfZE7Hu1igmvImT3JvggXV6Ieto5TdG1ZuCeIIvwvh0C4aTrOO48PE+tIg5bS9gvt6M=
Received: from BLAPR10MB5138.namprd10.prod.outlook.com (2603:10b6:208:322::8)
 by BL0PR10MB3428.namprd10.prod.outlook.com (2603:10b6:208:7c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Mon, 14 Feb
 2022 12:23:46 +0000
Received: from BLAPR10MB5138.namprd10.prod.outlook.com
 ([fe80::e1b9:9813:d7a8:8d30]) by BLAPR10MB5138.namprd10.prod.outlook.com
 ([fe80::e1b9:9813:d7a8:8d30%5]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 12:23:46 +0000
From:   Darren Kenny <darren.kenny@oracle.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko@kernel.org, jmorris@namei.org, serge@hallyn.com
Cc:     eric.snowberg@oracle.com, keescook@chromium.org,
        torvalds@linux-foundation.org, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        nramas@linux.microsoft.com, lszubowi@redhat.com, jason@zx2c4.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v8 11/17] KEYS: Introduce link restriction for machine keys
In-Reply-To: <20211124044124.998170-12-eric.snowberg@oracle.com>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
 <20211124044124.998170-12-eric.snowberg@oracle.com>
Date:   Mon, 14 Feb 2022 12:23:42 +0000
Message-ID: <m2leydtz5d.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: DU2P250CA0026.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::31) To BLAPR10MB5138.namprd10.prod.outlook.com
 (2603:10b6:208:322::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b14d613-cc2b-41c1-dc7b-08d9efb4d8c1
X-MS-TrafficTypeDiagnostic: BL0PR10MB3428:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB342804A180A65D6228F2E00AF4339@BL0PR10MB3428.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cFe9Dn8lQibHm91ATZAB/U4AB2fkAI+fP1p2LGAeRZ43iYuNK8PcoNd7JelxuGtQeOX8fX8alPnVz86AVzfgRY4s4/xckX5/UkJXQ8vKYfEWJLNqyr+ALoiil86SPcH0IPvjADtfcU/ncg+yfL+sgz1+keUKnck7yzaVqUZE9AQME124PZECGI2zAVnWZFXW/6Lr3fGwZ/Px/txQI84Y3bmtB1jQIvwOGSByzxM3JJdm23UO0iY6OY7N5pRqAJUl2JsVwbrDrdDHl0CAoqf0OEqTPvHIYtbI+/hwoFR4rr68iSVF0ATv55GaGsxXyx4uWy965poF6Z8tCeRIyPVHFTmas5JcYBfUgKXHph5nWfyNsNbl1S9uolYb7VGBCVdG0YSW9jC1q9Z6/te+d5bA3w9Egihydez6talHwytppQNwnTQ+2N1ear0Bdx1pj7PhoBo2bC/AAiDvFVpFRb0WkwokHv6n/25dPhPZ0X7UtcNVmIr6rAo3O/sE6OSb2yHJPpZKb148JkkwqV3rvp102qUgBhXXx+eyxeWDJ37VQ65iCO1yt0C2efWE1bn3awjoSdc3FkHdRzoDfst6mQOOkMuBO5SAOrz/qSBKqEyMR3Bn3uBoYuAhosK+jKGNvjK5KB1YB+h/RJkvpOmCJ0yvmXu+EWRUqiebjU8yH+BXxOSnoncydloHwio2Q6+sbISOsfMMZ0ZKvC3YoEcawV/7Li/M/Bs79iS1C7VuTGN9wRU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5138.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6666004)(6486002)(316002)(2616005)(66476007)(66946007)(66556008)(44832011)(36756003)(921005)(38350700002)(38100700002)(186003)(4001150100001)(26005)(6506007)(52116002)(5660300002)(107886003)(6512007)(8936002)(7416002)(4326008)(86362001)(2906002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RT9qkag9Sv7xj6/JN4fg3SkEe8RNnkiibb3Enc3oq+vbgZ9Xjovnv6/+g39s?=
 =?us-ascii?Q?zsPWV0x+gmmneAuouMz41/LBnwl5to65UbAHDPgQRPv0EYnUPwOPVvgpXUrJ?=
 =?us-ascii?Q?BbU87ACF5XNluC/Udi9eSDxH/78tz0jqjZ/iKc1xNwE1KnnH7FS/6B5TZDUE?=
 =?us-ascii?Q?swi2oUtA6hfjJqNEePo7k1fYwl7JdPvXS17/sPBuJbu4GhSUy+8NY7IRKwBF?=
 =?us-ascii?Q?PT9xGoddlRO8pqcIT1s86ljq29aKkhcYqmuem6Tvx4t5yFECnE9wfP6cKbbl?=
 =?us-ascii?Q?jfWOvBIf8a7xzq3WirtPpjrmWWvgwaqIbrLSRShjXcd4Qey36nKAVPRgMDMh?=
 =?us-ascii?Q?gUp3lCXydGnmZ/cAhT7IJ1YovuGGFRhMD/Vvl4WrY5LbrjiCzT6dAsCUdeHz?=
 =?us-ascii?Q?Dg6Eg45f1iVF4qrxXlaZvIOdFj9PMoxIzUA/nFhcmTZSLZw8VG8o7ssRYeym?=
 =?us-ascii?Q?y7fBcsQrfKyAe75zbOWkbxuuuqipnJERZvU+x2kDEi7UK1v3/5fP8/Qckd7U?=
 =?us-ascii?Q?TPAvEDTqWS9N4nkB8oo4gZAuCNF/AHmn+XwYHq5g+bcgWbEVdRcOpMkjhgoe?=
 =?us-ascii?Q?m8xuwHsWKhYn1YSlwAwkPqmb6OwOKD+KopIYv4myLRSVV9bIx4ILNE0yojgr?=
 =?us-ascii?Q?mF/zvcxJ6fKaDB+xUQgxUTJRcXW4QQsaeJ8k/l/9oEsifKZEQq8sqyA1dEdb?=
 =?us-ascii?Q?i30n3kqLzhA7BNgjknF4qYtwN9waZa0CHJ7vI6tHcefSSsSoEnoCqbD+69LR?=
 =?us-ascii?Q?r5/g/iPizN6nZOmZHqZr3VCWdGFu8a2jANLiG8T3vRQjxARK0nb27Rl2UP3Y?=
 =?us-ascii?Q?xzAvHXGlLue1B8eL7rnnYti68ofF30Z/Mx6/kwnZgpGNAKP573tGV883sWEk?=
 =?us-ascii?Q?mdbYKDCbDKOvU3Wkav5YejFdVPib5K+v9cvG2daYMbkK9wsR6PT1024Jeufn?=
 =?us-ascii?Q?cc2/aQv1ML0DCdcGjUeZUaHPpssHNyKKJ5nL4TZpV4QZGT6h7i2qpPmYnzKu?=
 =?us-ascii?Q?Ik/UzxmTv5+AItHSh6MNItIUhNWYYQgeUpx2iOJ8MzSM1ZqEyszYko/BL3kH?=
 =?us-ascii?Q?dqjDI/p/6KoL74kccyyeVP3zFwfu0ShB+eVxD5KXtXZKbeNbfydp+Qmj9kiV?=
 =?us-ascii?Q?yuq6rbx2kbPL9Rd+a8/IkH8F9oSMBcXF4QrVqwiACRgG5NEtvK3ysNwiTOwP?=
 =?us-ascii?Q?Hlp82fvVUJM8TsaU6GCd4JqwDev+A2P6Mjxn6wpKjHx3lxOIW4L7vIVcOqN1?=
 =?us-ascii?Q?p6mMmoEPQu4lyMhbw24e9bRk+IdwcQEpFYMM7GcZnmkdWTB01K2xUJ//bwcp?=
 =?us-ascii?Q?Hrf8K4bnsU3qGOFGtKxfRQKk1F0V/Tp2wuH+slXt1DTwA9rShOtyo08PehLg?=
 =?us-ascii?Q?HSyaqcB6BT2RiMrIJCmuiJE0IUF9uy7iCV61YHem8bTFXu6fkSTxnZsisEQl?=
 =?us-ascii?Q?cpHCsFcNH4E6FQDdrs/oQP2Aduvp+bPqBs2KwT5LwmtTUZtXERqQm0DE87qO?=
 =?us-ascii?Q?icm+qf5vMvrf50/CnADu2WZNCKL8QehuiS86tkRQ1ks5s7xj2c+WuOkIRxYB?=
 =?us-ascii?Q?Zi5U8d/ThqlzbMIrnbQlXaVMuH9AoErOwSwy4pZz6X2+WuAvA1lG85YWjz/L?=
 =?us-ascii?Q?x2j9vrb1CYQL3gPvlRNF29g=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b14d613-cc2b-41c1-dc7b-08d9efb4d8c1
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5138.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 12:23:46.4214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQS11RtA3oNFlSek4OxRmjYOHx70KBKi3jDixUVU5rpbvwk88Smjd54AcldQ4oFp1qwtj6Yc6WjJfzjuMMv/PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3428
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10257 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202140075
X-Proofpoint-GUID: hAS86-atR5WM5iAUOdJrc9ze7GOs9tts
X-Proofpoint-ORIG-GUID: hAS86-atR5WM5iAUOdJrc9ze7GOs9tts
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tuesday, 2021-11-23 at 23:41:18 -05, Eric Snowberg wrote:
> Introduce a new link restriction that includes the trusted builtin,
> secondary and machine keys. The restriction is based on the key to be
> added being vouched for by a key in any of these three keyrings.
>
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

> ---
> v3: Initial version
> v4: moved code under CONFIG_INTEGRITY_MOK_KEYRING
> v5: Rename to machine keyring
> v6: Change subject name (suggested by Mimi)
>     Rename restrict_link_by_builtin_secondary_and_ca_trusted
>       to restrict_link_by_builtin_secondary_and_machine (suggested by
>       Mimi)
> v7: Unmodified from v6
> v8: Add missing parameter definitions (suggested by Mimi)
> ---
>  certs/system_keyring.c        | 27 +++++++++++++++++++++++++++
>  include/keys/system_keyring.h |  6 ++++++
>  2 files changed, 33 insertions(+)
>
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index bc7e44fc82c2..8a2fd1dc15db 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -99,6 +99,33 @@ void __init set_machine_trusted_keys(struct key *keyring)
>  {
>  	machine_trusted_keys = keyring;
>  }
> +
> +/**
> + * restrict_link_by_builtin_secondary_and_machine - Restrict keyring addition.
> + * @dest_keyring: Keyring being linked to.
> + * @type: The type of key being added.
> + * @payload: The payload of the new key.
> + * @restrict_key: A ring of keys that can be used to vouch for the new cert.
> + *
> + * Restrict the addition of keys into a keyring based on the key-to-be-added
> + * being vouched for by a key in either the built-in, the secondary, or
> + * the machine keyrings.
> + */
> +int restrict_link_by_builtin_secondary_and_machine(
> +	struct key *dest_keyring,
> +	const struct key_type *type,
> +	const union key_payload *payload,
> +	struct key *restrict_key)
> +{
> +	if (machine_trusted_keys && type == &key_type_keyring &&
> +	    dest_keyring == secondary_trusted_keys &&
> +	    payload == &machine_trusted_keys->payload)
> +		/* Allow the machine keyring to be added to the secondary */
> +		return 0;
> +
> +	return restrict_link_by_builtin_and_secondary_trusted(dest_keyring, type,
> +							      payload, restrict_key);
> +}
>  #endif
>  
>  /*
> diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
> index 98c9b10cdc17..2419a735420f 100644
> --- a/include/keys/system_keyring.h
> +++ b/include/keys/system_keyring.h
> @@ -39,8 +39,14 @@ extern int restrict_link_by_builtin_and_secondary_trusted(
>  #endif
>  
>  #ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
> +extern int restrict_link_by_builtin_secondary_and_machine(
> +	struct key *dest_keyring,
> +	const struct key_type *type,
> +	const union key_payload *payload,
> +	struct key *restrict_key);
>  extern void __init set_machine_trusted_keys(struct key *keyring);
>  #else
> +#define restrict_link_by_builtin_secondary_and_machine restrict_link_by_builtin_trusted
>  static inline void __init set_machine_trusted_keys(struct key *keyring)
>  {
>  }
> -- 
> 2.18.4

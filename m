Return-Path: <linux-efi+bounces-21-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE597E775C
	for <lists+linux-efi@lfdr.de>; Fri, 10 Nov 2023 03:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08A1D1C209BD
	for <lists+linux-efi@lfdr.de>; Fri, 10 Nov 2023 02:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3181363;
	Fri, 10 Nov 2023 02:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="mXj0zlwU";
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="LD08jXxN"
X-Original-To: linux-efi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5D310F2;
	Fri, 10 Nov 2023 02:22:52 +0000 (UTC)
Received: from rcdn-iport-2.cisco.com (rcdn-iport-2.cisco.com [173.37.86.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B80420B;
	Thu,  9 Nov 2023 18:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3578; q=dns/txt; s=iport;
  t=1699582971; x=1700792571;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=B7JYBJU6QBps/roSTVx2aQVbBc5hudjWVLDcr0R6610=;
  b=mXj0zlwUWcXY9AjIxuHJ2helLKkYq7CksfZHgjYyYhHecmY8+xRDnXU4
   LRvAC68W9Ng4Awjk+cP+W8YwbB2fjjW1VbakWUkvTwFR/Db+wJI88PzPR
   1FGas11FCQP2lhV2Dn2bwn/Q1QgSChumXpE9Ld5a21Cplw6OHqEYoDdRG
   s=;
X-CSE-ConnectionGUID: 9dfve5gdRomCV1Kvq8TDuA==
X-CSE-MsgGUID: HxcCFtj8TqGTrT5efH+1mw==
X-IPAS-Result: =?us-ascii?q?A0B5AADSkk1lmJ1dJa1aHQEBAQEJARIBBQUBQCWBFggBC?=
 =?us-ascii?q?wGBZlJ4WyoSSIgeA4ROX4hjA4V6jEMciyWBJQNWDwEBAQ0BAUQEAQGFBgKHJ?=
 =?us-ascii?q?gImNAkOAQICAgEBAQEDAgMBAQEBAQEBAgEBBQEBAQIBBwQUAQEBAQEBAQEeG?=
 =?us-ascii?q?QUQDieFaA2GTAEBAQECARIoBgEBNwEECwIBCA4KHQEQECIlAgQOBSKCXII8I?=
 =?us-ascii?q?wMBoV8BgUACiih4gTSBAYIJAQEGBAWybQmBSAGICwGKCicbgUlEhD8+gmECg?=
 =?us-ascii?q?VEPhkOHCoIfBzKBCgwJKlmDUoMPijxdIkdwHQMHA38QKwcELRsHBgkUGBUjB?=
 =?us-ascii?q?lEEKCQJExI+BIFjgVEKfz8PDhGCPyICBzY2GUiCWxUMNEp2ECoEFBeBEgRqG?=
 =?us-ascii?q?xUeNxESFw0DCHQdAhEjPAMFAwQzChINCyEFFEIDQgZJCwMCGgUDAwSBNgUNH?=
 =?us-ascii?q?gIQGgYNJwMDE00CEBQDHh0DAwYDCzEDMIEZDFEDbx82CTwPDB8COQ0nKAI1V?=
 =?us-ascii?q?wUSAhYDJB1FA0QdQAN4PTUUGwZnoTSBIIFaAQ8WEoEyCzWSeIJrAa58CoQNo?=
 =?us-ascii?q?WmDboxzmQ+YP6JeS4R/AgQCBAUCDgEBBoFjOoFbcBWDIlIZD44gDA0Jg1aPe?=
 =?us-ascii?q?XY7AgcLAQEDCYhwgloBAQ?=
IronPort-PHdr: A9a23:Lm7jyB1N+z2jACCmsmDPZ1BlVkEcU/3cNwoR7N8gk71RN/jl9JX5N
 0uZ7vJo3xfFXoTevupNkPGe87vhVmoJ/YubvTgcfYZNWR4IhYRenwEpDMOfT0yuBPXrdCc9W
 s9FUQwt5Gm1ZHBcA922fFjOuju35D8WFA/4MF95L+L0F4rNhuy81vu5/NvYZAAbzDa4aKl5e
 Q2/th6Z9tFDmJZrMK831hrPrzNEev8Dw2RuKBPbk0P359y7+9ho9CE4hg==
IronPort-Data: A9a23:VTSA7KPmEh7JPITvrR0tl8FynXyQoLVcMsEvi/4bfWQNrUomhDEPz
 zNMDDqHMvuKYTT8co91bYW1/UoH6pGDyoMyG3M5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCdaphyFjmF/kvF3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/W1jlV
 e/a+ZWFYwb8gmYsawr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQrl58R7PSq
 07rldlVz0uBl/sfIorNfoXTLiXmdoXv0T2m0RK6bUQNbi9q/UTe2o5jXBYVhNw+Zz+hx7idw
 /0V3XC8pJtA0qDkwIwgvxdk/y5WbKFI5rKaLnSFtsm48RTlbWK8/9lzJRRjVWEY0r4f7WBm7
 /cULnUGaQqOwrzwy7OgQe4qjcMmRCXpFNpA4Tc7kneIVrB/HM+rr6bivbe02B88j8ZPEPLBb
 uISaCFka1LLZBgn1lI/UcljwLn02yOiG9FegHKFroEZ/2qD8BVe7KLRbdfbWp/TQNoAyy50o
 UqfrzimXXn2Lue3zTuD72Lpi+HOtT30VZhUF7Ci8PNuxlqJyQQ7DBwQSEv+ovOki0qyc8xQJ
 lZS+Sc0q6U2skuxQbHVUxCmoXWJogQRVvJOHOAgrgKA0KzZ50CeHGdsZjpAbsE28cw7Xzon0
 neXkN7zQz9iqruYTTSa7Lj8hTezPzUFaGoDfTQsUwQI+Z/grZs1gxaJScxseJNZlfXvEj32h
 juNtiV72fMYjNUA0OOw+lWvby+QSobhHwI7+AiKUW6f6QZSWteGeZX41XTGxKMVRGqGdWWps
 H8BksmYyekBC5CRiSCAKNnh+pn0uZ5p1xWB3DZS84kdGyeFoCH8INgBiN1qDAI4bZZeIG6Bj
 Fr74FsJvPdu0G2Wgbibir9d5uwwxqTmUN/iTP2RMJxFY4N6c0mM+yQGia+sM4LFzhREfUIXY
 MrznSOQ4ZAyVf0PIN2eHLZ17FPT7npirV4/vLiip/hd7ZKQZWSOVZAOO0aUY+Yy4cus+VuEo
 osCa5XWm04ADIUShxU7F6ZNdDjmylBlXfjLRzB/KoZv3yI/Qjh6Uq+NqV/fU9Y5xfo9ehj0E
 oGVAx8ElwWXaYzvIgSRYXcrc6L0QZt6thoG0d8EYz6VN4wYSd/3ts83LsJvFZF+rbwL5aAvF
 ZEtJZ7fasmjvxyaoVzxm7Gn8tw7HPlq7CrTVxeYjM8XJsUwH1CZpY+4LmMCNkAmV0KKiCf3m
 JX5vivzSpsYTAMkB8HTAM9DBXvo1ZTBsIqeh3f1H+Q=
IronPort-HdrOrdr: A9a23:4iDR5KnwaxYKpDc757lxddcOqEvpDfNQiWdD5ihNYBxZY6Wkfp
 +V7ZcmPE7P6Ar5BktApTnZAtjwfZq9z/JICYl4B8baYOF/0FHYYr2KnrGSswEIfBeOt9K1tJ
 0QPJSWbeeAb2SS4vyKnTVQf+xQp+VvtZrY+9s2rE0dDT2CCZsQkzuRYzzzeiYZNWw2YabRVq
 DsmfavzADQAUj/G/7LfEXtKNKz3OEj+qiWByIuNloM0iXLpzWu77LxDhif2Tkjcx4n+90f2F
 mAuTbUooG4vd+G6jK07QLuBpJt9+fJ+59mPoihm8IVIjLjhkKDf4J6QYCPuzgzvaWG9EsquM
 OkmWZjA+1Dr1fqOk2lqxrk3AftlBw07WX59FOeiXz/5eTkWTMBDdZbj44xSGqd16NghqA57E
 t45RPei3NlN2KYoM073amRa/herDvynZPlq59Js5UQa/pFVFYbl/1twKocKuZzIMu90vFlLA
 GrZ/usuMq/tjihHi3kl3gqz9q2UnspGBCaBkAEp8yOyjBT2Gt01k0C2aUk7z09Hb8GOtF5Dt
 7/Q+9VvaALStVTYbN2Be8HT8fyAmvRQQjUOGbXJVj8DqkIN3/EtpayudwOla2XUY1NyIF3lI
 XKUVteu2J3c0XyCdeW1JkO9hzWWm2yUTnk18kb7Zlkvb/3QqbtLES4OR0Tutrlp+9aDtzQWv
 61Np4TC/j/LXH2EYIMxAH6U4k6EwhWbCTUgKdMZ7ujmLO9FmSxjJ2vTB/6HsuYLQoZ
X-Talos-CUID: 9a23:Ni5paW3KhIcJR9eADJHLKbxfS8wrbHCAw3vqJEqTNz9KVqTFdXON0fYx
X-Talos-MUID: =?us-ascii?q?9a23=3A3EFgwQ/rXmNEBPQ48MZPnhOQf+d46I+AFEJdrYw?=
 =?us-ascii?q?ph9O4aCF+G3TEiSviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-6.cisco.com ([173.37.93.157])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 02:22:50 +0000
Received: from alln-opgw-4.cisco.com (alln-opgw-4.cisco.com [173.37.147.252])
	by rcdn-core-6.cisco.com (8.15.2/8.15.2) with ESMTPS id 3AA2MnUg008365
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 02:22:49 GMT
X-CSE-ConnectionGUID: /u25q1JGRrKLe7yy31dhbA==
X-CSE-MsgGUID: eGDr26SBToqqmWi0XZvang==
Authentication-Results: alln-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=danielwa@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.03,291,1694736000"; 
   d="scan'208";a="7784892"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by alln-opgw-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 02:22:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlE2M6/zraXxJzO1WT1p5Yo2fuigjBglmBfcnUJZJpvMC94j5AugxLMC/8Qnwo9yp+Xa9xviJd0WEL1Vuz6t0M78od/TsPg25nwfRDPZ8B84djYoZDJWu6+MbaoJayNufXlBRreEhvjcFsq3mCtJzdjd7REG619hnV70SZARTyTYfasuh8MqjwGK6S2tOw6iDYcp8ymP3AXM2gDflWTGQqA2ekosgo4bYsEBQr9c270FKx5LFH3ehDoM/hjLS858YI8Rc0yeWWnexBaMX81NQongGyJrSIPqiRt4LNhH8KrU1wrzbdrlSibAP2RZKW3thk96ExhvRygxew7Zz29xFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXHlYCdqJf2Sg5u51PQkvsB2ASTaVj/Eqw/qJgZXTTQ=;
 b=J3yXeRLbSiUWGu0sr9btAZQswEFvrckp2v7Y5hdpUQK4Zq5yertaNieDk5hHavsIbtoUzGbxtS6VnZkVU/u3IjwYAu5NGThaJprhZdIZxa53UY52rGikm7J+gzrMUjRMPlrmIOBNhriRCzktVNLuBVyrOjFqwHktALPMwTpdTXDW486LrWs4iUORkGq3TzTKyNyW9E8QyTCarDRrDwZBrjEiT/lO4j8ZnTPRX++7QKeHc3WJXgqqv1Cckntr+EU6TPzlhapq3GJhmMTUKIF01PF1s0W6rOpjYf33STH2eCnZdoN//2iCORTcbjvaivKcW4pICyWFfYO/wJo66daXWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXHlYCdqJf2Sg5u51PQkvsB2ASTaVj/Eqw/qJgZXTTQ=;
 b=LD08jXxNtfA3jyF/5fY8HJGVkzygQ/WoUSEIGDec56bzrw3OmBfmnv2lXS1fF4aLB2ZhiaHHS96bDKCKimm77qqhE1oZQu3YCaN9y4e8cUJdt4gfZmRL6nxDsibaCQcUT/d8h7ZUAxu22XcUrEo2AbxuON/QrS52+8TnIX+B24U=
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com (2603:10b6:a03:422::15)
 by PH0PR11MB4950.namprd11.prod.outlook.com (2603:10b6:510:33::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 02:22:27 +0000
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::a59:2fb9:3446:4f8]) by SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::a59:2fb9:3446:4f8%6]) with mapi id 15.20.6977.018; Fri, 10 Nov 2023
 02:22:27 +0000
From: "Daniel Walker (danielwa)" <danielwa@cisco.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: Will Deacon <will@kernel.org>,
        Christophe Leroy
	<christophe.leroy@csgroup.eu>,
        Rob Herring <robh@kernel.org>,
        Daniel
 Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        Pratyush Brahma
	<quic_pbrahma@quicinc.com>,
        Tomas Mudrunka <tomas.mudrunka@gmail.com>,
        Sean
 Anderson <sean.anderson@seco.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "H. Peter
 Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick
 Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kbuild@vger.kernel.org"
	<linux-kbuild@vger.kernel.org>,
        "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>
Subject: Re: [PATCH 0/8] generic command line v6
Thread-Topic: [PATCH 0/8] generic command line v6
Thread-Index: AQHaE3y/55d8FUfbk020UwDeu5551A==
Date: Fri, 10 Nov 2023 02:22:27 +0000
Message-ID: <ZU2T3VPYosP+ZR1b@goliath>
References: <20231110013817.2378507-1-danielwa@cisco.com>
 <20231109175142.49428d5f51325680764663bf@linux-foundation.org>
In-Reply-To: <20231109175142.49428d5f51325680764663bf@linux-foundation.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5790:EE_|PH0PR11MB4950:EE_
x-ms-office365-filtering-correlation-id: 5b67ce5c-ba34-4985-9529-08dbe193e216
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +zhcYj6Fuoy/Qc4nMSsUL1uXCx4Z1rIeE6hRjknjaPnDYEgYsh4snetOqvLFKQmgT8G5He4CJ982A1OMXcQhOIpAwWFll6P0BzfPeoq4l5z300W9QDyo1rf9HJ/1oF/1FOAinGPWdERqxTp5Y8drw1Og0Keg19UsA6qNQwdb5qiCv/IKpS3E9EtMIkObkGaeneYildjiA5iYhecKXnQ36Z7QHILIfcln51bvuIg9R6G5rc56ESLDo5HMRdD0zPTnZm9OprzV01E1raSSrEYR9Z2Gy0RnUBVzcxE+NywbMZMVP6wPjPke8A1LY90zFPFP/4fFGLQwb0OFWf+LWKcp7QtbbJ+nr8idFERsptV3Jm6Ss0+M/YHYCNA1iIdFK7VHQ2PjJQCtj6y4ctvXIADFE9OkM1VPNShoGm/tlGnX6NtaNabQrstgZjrPXS01GVX0guq1AOONzuQV4wy7kWE16dG9fij+VdqPdB1M9s83KNU0AaeZFQVFSYkl/0rffvqm4IdDBl+xei8/Fa4IrQbZAm5YYj+ow7le6aH61y9vIWIvopkryZWLznhjgBkoAkdDqn8jtAscHRSlPGm5Cm5Ln80uPWAvcnqjEpWMhE6RgUzFaFkHvEY8pGewlxAv1mjfLO5epog8BOMghhh4LV82FBLneg095E6QkZzPTVyiwOE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(136003)(346002)(376002)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2906002)(66899024)(83380400001)(86362001)(38070700009)(33716001)(38100700002)(26005)(122000001)(71200400001)(6506007)(76116006)(4326008)(8936002)(8676002)(6512007)(9686003)(66556008)(64756008)(54906003)(41300700001)(66946007)(66446008)(316002)(478600001)(6486002)(6916009)(66476007)(5660300002)(7416002)(41533002)(67856001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RbZZDjEqfAyAMejfoGvAQTwCxM1j/ck4InsyxTHAG0gkwne7HJkDHHEmoswy?=
 =?us-ascii?Q?JnrmrquKNaXCrBQHtdI4B7vLYD+TG4t1vSKnqBvd1JjtjxhY/TySQey1ri8L?=
 =?us-ascii?Q?moyCVGtvAtNz+EPR0+/EnONnHKcbnbb2FvGESlby8c1hDxwXvi8ZiiUTTxVv?=
 =?us-ascii?Q?kznFKPQuWAt+GTdChUoxk+F/4+iDeMGjV4Qx/qup6PsTrEpfnl5gQwRxyCqS?=
 =?us-ascii?Q?9aOuc8IAZCWeXtAVwpgYG25fNMCE+w6VBsqhlM6L9gY9S9+RcqFdsj3JhMQV?=
 =?us-ascii?Q?0S+ocLF+moER6+zHT5AVGcstlD/+Z8P67cod6q36CtGMpmBQ7jn9/UXu3Jd/?=
 =?us-ascii?Q?XF/fYIwAHSXtQ4ZlLtdbd/snQcwisYZ5uG02hcpj/4ZHSWQUpqP4PyLpRalM?=
 =?us-ascii?Q?f+Gr10KxFVsPqVF0qCic9yuAnIapJix4pKl04MKNCpE01krv5O15dLZVo6Gg?=
 =?us-ascii?Q?+T7StuWRjuZ4xWPy3p1E2hhFl3Rjs8J0KKpQjPnWTeJrv6vVx4ThZq1/2Pj6?=
 =?us-ascii?Q?j7zoD/9NjM0Tc97JEO61o6P9v+fo/cOqijNHysZxjnWMGhMS3bFtA6f67r6R?=
 =?us-ascii?Q?It2cEssc0Nu5fv5ORdW4OEgALiFoDlprlbSxQhDwdoqpx7SIjcTI1w+DHRg/?=
 =?us-ascii?Q?8y+KK/2OfNBFqeh5xTPtfC2mTXpw0UfjY6OC/51zYqCCLMT4yzKbSZEkwTbV?=
 =?us-ascii?Q?+O5Cpe1qoM63/AiWm/MQNGD11fQZNuyDOE2LLl/HKQ3iUqs5P6o1ASD5ihVy?=
 =?us-ascii?Q?uwIxCi1QMRcjrSFLrmqdLPwzg0tAM/LHsP28dyhbIdIgnJ4APGt3YbyK4X9L?=
 =?us-ascii?Q?Nk66G2Z7EohjISfpkG8bYMQ6cR6KweaWzz/ON111KKAtIAPEpr5ZPOt0HVb3?=
 =?us-ascii?Q?QDFC/l6Zpbhe1qdXdnlso7w2ixRf5RrICvS+GlOaOxRaDdV7YiYRvftsor8D?=
 =?us-ascii?Q?nLHg5P0M7+5GJbdRMMb3cUlfA3YRtT/SYPGnpxcX/ALKc3SFH7Jsr+f/3e2f?=
 =?us-ascii?Q?+EuYrwADtsKeTcJ0uajXrHJOzQ09JRxH8UdpROhimuf92lRFQ6oni3tsBMYh?=
 =?us-ascii?Q?57faWlj9wWWWCihf8UR16SkIX2rSkNGEg2Iv865DXHKfuOm1cx0MZUhtJWt5?=
 =?us-ascii?Q?uPdyLlRaKQ6FQCjwSimzgiCOI4jBIU6Y4nWFgJhJmgCQ3reitdR7xWlhTNxz?=
 =?us-ascii?Q?bNIezK+AJSL5uh1ixdLtGfm3OoUZ7ksAYE4qQbyGo+Zg3hLG3ud8yr9uefl7?=
 =?us-ascii?Q?DRBkDJ5PniWHx6Tf/wMpfL0YPBXoA3K4YDIRy0EQQ/BI87pPBWY0RascAifw?=
 =?us-ascii?Q?ppACTA4qugKbWXLSWMv3kPZC/rDOKCLb6TghyaeVgK1faiB7p+9zyVsDlcOW?=
 =?us-ascii?Q?COnwJm16gFezut+FR915jngoJcq/sT2ai4FhUtYJ5de9NYXYQNNTZO8ONc+q?=
 =?us-ascii?Q?Lmlo2e6DdqjAh25fitWq2RkdXOY3GHiNbouRMZ0boS7bRJ2KCTVVadvgRQ65?=
 =?us-ascii?Q?PdsYutWltNBBLwXgGF4NGnbNoCZ+nXzkTLkyUE1KLWxIt97IRQmAOoiIuk9C?=
 =?us-ascii?Q?GdmpDiqUmuaMZc27SNkB1qhYzJYRYOyfNupjzBcD?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3092527A105ADF46AAF5421F010E28FE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b67ce5c-ba34-4985-9529-08dbe193e216
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 02:22:27.2043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KK4UR6e7pN9Me3SPGW3ogy0duaxcxJb4VhqtTqpVAHvrZyIt27moF2skLKZ+BT1Q6y+6pDStO6oEQXp2OUNRJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4950
X-Outbound-SMTP-Client: 173.37.147.252, alln-opgw-4.cisco.com
X-Outbound-Node: rcdn-core-6.cisco.com

On Thu, Nov 09, 2023 at 05:51:42PM -0800, Andrew Morton wrote:
> On Thu,  9 Nov 2023 17:38:04 -0800 Daniel Walker <danielwa@cisco.com> wro=
te:
>=20
> > This release is an up-rev of the v5 patches. No additional features hav=
e
> > been added. Some changes were mode to function names and some changes t=
o
> > Kconfig dependencies. Also updated the config conversion for mips.
> >=20
> > There are a number of people who have expressed interest in these
> > patches either by asking for them to be merge or testing them. If
> > people are so inclined please continue to request them to be merge
> > or to ask the status of the next release. It's helpful to motivate me t=
o
> > release them again and for the maintainers to see the interest
> > generated.
> >=20
> > These patches have been used by Cisco Systems, Inc. on millions of
> > released products to great effect. Hopefully they can be used by the
> > entire Linux eco system.
> >=20
>=20
> fyi, none of the above is suitable for a [0/N] changelog - it's all
> transitory stuff which tells readers nothing much about what the
> patchset does.
=20
I did not think about it this way. It's because I've submitted this so many
times. I guess I assume everyone knows what it is.

> And that info is sorely missed.  I can see that it's a code cleanup,
> but I'm sure Cisco wouldn't expend resources to maintain such a thing.=20
> There's something else here.

I think the prior submissions there was no cover letter, maybe I should jus=
t
achoo that entirely.

> In [1/8] I see "Even with mips and powerpc enhancement the needs of
> Cisco are not met on these platforms" and "This unified implementation
> offers the same functionality needed by Cisco on all platform which we
> enable it on".
>=20
> Well OK, what are these needs?   What functionality changes does this
> patchset offer which Cisco finds useful?  IOW, what were the
> requirements?  What's wrong with the old code and how does this
> patchset fix/enhance that?

The limitation is that you can't append and prepend to the command line at =
the
same time in any of the architectures. Having access to both allows OEMs to=
 deal
with broken bootloaders which can't easily be upgraded. Others have respond=
ed
that they also use these patches for this same reason.

In 2/8 and 3/8 I modify the insert-sys-cert tool to allow modification of t=
he
command line append and prepend after the build. This allow for an SDK
provided with a binary kernel and for the command line append/prepend to st=
ill
be modified identically to how that's done with certificates.

Making all this generic means each platform has a unified set of command li=
ne
services. Cisco uses x86/arm32/arm64/mips/powerpc , and it's nice to have a=
ll
the same features across platforms.

>=20
> I see the patchset updates nothing under Documentation/.  Should it do
> so?  Could it do so?

The only documentation is Kconfig descriptions and commit messages. I suppo=
se it
could have something under Documentation/. The only part which could use mo=
re
documentation are the changes in 2/8 and 3/8. That feature is maybe confusi=
ng
and has limitations which are maybe not clear. Although the same limitation=
 exist for
inserting certificates.

>=20
> I don't know what is the expected merge patch for this work.  I can
> grab them if no other maintainer is in the firing line.

merge patch ? Do you mean merge description ? I think your the maintainer i=
n the
firing line for this one.

Daniel=

